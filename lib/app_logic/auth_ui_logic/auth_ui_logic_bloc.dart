import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:phone_auth_microservice/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:phone_auth_microservice/domain/models/auth/auth_failure.dart';
import 'package:phone_auth_microservice/domain/models/auth/i_auth_repository.dart';
import 'package:phone_auth_microservice/domain/models/auth/user_model.dart';

part 'auth_ui_logic_bloc.freezed.dart';

part 'auth_ui_logic_event.dart';

part 'auth_ui_logic_state.dart';

@injectable
class AuthUiLogicBloc extends Bloc<AuthUiLogicEvent, AuthUiLogicState> {
  AuthUiLogicBloc(this._iAuthRepository, this._firebaseAuth)
      : super(AuthUiLogicState.firstStep(UserModel.empty)) {
    on<AuthUiLogicEvent>(
      (AuthUiLogicEvent event, Emitter<AuthUiLogicState> emit) async {
        await event.map(
          ///userModelChanged
          userModelChanged: (_UserModelEvent event) {
            getLogger().i('userModelChanged Started');
            emit(state.copyWith(userModel: event.userModel));
          },

          ///stepChanged
          stepChanged: (_StepChangedEvent event) {
            getLogger().i('stepChanged Started');
            if (event.stepNumber == 1) {
              emit(AuthUiLogicState.firstStep(state.userModel));
              return;
            }

            if (event.stepNumber == 2) {
              emit(
                  AuthUiLogicState.secondStep(state.userModel, 0, _controller));
              return;
            }
            if (event.stepNumber == 3) {
              _timer?.cancel();
              emit(AuthUiLogicState.thirdStep(state.userModel));
              return;
            }
          },

          ///sendCodePressed
          sendCodePressed: (_SendCodePressed event) async {
            getLogger().i('sendCodePressed Started');
            emit(AuthUiLogicState.secondStep(state.userModel, 60, _controller));
            _startTimer(60);
            await _firebaseAuth.verifyPhoneNumber(
              phoneNumber: state.userModel.phoneNumber,
              timeout: const Duration(milliseconds: 10),
              verificationCompleted:
                  (PhoneAuthCredential phoneAuthCredential) async {
                Either<AuthFailure, UserModel> userModelOrFailure =
                    await _iAuthRepository.verificationCompleted(
                        phoneAuthCredential,
                        state.userModel.phoneNumber,
                        _controller);
                getLogger().i(
                    'userModelOrFailure from verificationCompleted:$userModelOrFailure');
              },
              verificationFailed:
                  (FirebaseAuthException firebaseAuthException) async {
                Either<AuthFailure, UserModel> userModelOrFailure =
                    await _iAuthRepository
                        .verificationFailed(firebaseAuthException);
                getLogger().i(
                    'userModelOrFailure from verificationFailed:$userModelOrFailure');
              },
              codeSent: (String verificationId, int? resendToken) async {
                Either<AuthFailure, UserModel> userModelOrFailure =
                    await _iAuthRepository.codeSent(verificationId, resendToken,
                        null, state.userModel.phoneNumber);
                getLogger()
                    .i('userModelOrFailure from codeSent:$userModelOrFailure');
              },
              codeAutoRetrievalTimeout: (String verificationId) {
                getLogger().i('codeAutoRetrievalTimeout :$verificationId');
              },
            );
          },

          ///smsCodeTimerTick
          smsCodeTimerTick: (_SmsCodeTimerTick event) {
            getLogger().i('smsCodeTimerTick Started');
            emit(AuthUiLogicState.secondStep(
                state.userModel, event.secondsRemaining, _controller));
          },

          ///reSendCodePressed
          reSendCodePressed: (_ReSendCodePressed event) {
            getLogger().i('reSendCodePressed Started');
            add(const AuthUiLogicEvent.sendCodePressed());
          },

          ///smsCodeFilled
          smsCodeFilled: (_SmsCodeFilled event) async {
            getLogger().i('smsCodeTimerTick Started : ${event.code}');
            _timer?.cancel();
            emit(AuthUiLogicState.thirdStep(state.userModel));
            getLogger().i('smsCodeTimerTick Started : ${event.code}');

            final Completer<void> verificationCompleter = Completer<void>();

            final subscription = verificationStream.listen(
              (Either<AuthUiLogicState, UserModel> verificationResult) {
                verificationResult.fold(
                  (AuthUiLogicState newState) {
                    getLogger().e('waiting$newState');
                    emit(newState);
                  },
                  (UserModel userModel) {
                    getLogger().e('userModel $userModel');
                    emit(AuthUiLogicState.authorizedUser(userModel));
                  },
                );
              },
            );
            await _firebaseAuth.verifyPhoneNumber(
              phoneNumber: state.userModel.phoneNumber,
              timeout: const Duration(seconds: 60),
              verificationCompleted:
                  (PhoneAuthCredential phoneAuthCredential) async {
                Either<AuthFailure, UserModel> userModelOrFailure =
                    await _iAuthRepository.verificationCompleted(
                        phoneAuthCredential,
                        state.userModel.phoneNumber,
                        _controller);
                getLogger().i(
                    'userModelOrFailure from verificationCompleted:$userModelOrFailure');
                userModelOrFailure.fold(
                  (AuthFailure failure) {
                    getLogger().e('failure:$failure');
                    _streamController.add(left(AuthUiLogicState.errorState(
                        state.userModel, failure, _controller)));
                    verificationCompleter.complete();
                  },
                  (UserModel userModel) {
                    getLogger().i('userModel:$userModel');
                    _streamController.add(right(userModel));
                    verificationCompleter.complete();
                  },
                );
              },
              verificationFailed:
                  (FirebaseAuthException firebaseAuthException) async {
                Either<AuthFailure, UserModel> userModelOrFailure =
                    await _iAuthRepository
                        .verificationFailed(firebaseAuthException);

                getLogger().i(
                    'userModelOrFailure from verificationFailed:$userModelOrFailure');
                userModelOrFailure.fold(
                  (AuthFailure failure) {
                    getLogger().e('failure:$failure');
                    _streamController.add(left(AuthUiLogicState.errorState(
                        state.userModel, failure, _controller)));
                    verificationCompleter.complete();
                  },
                  (UserModel userModel) {
                    getLogger().i('userModel:$userModel');
                    verificationCompleter.complete();
                  },
                );
              },
              codeSent: (String verificationId, int? resendToken) async {
                Either<AuthFailure, UserModel> userModelOrFailure =
                    await _iAuthRepository.codeSent(verificationId, resendToken,
                        event.code, state.userModel.phoneNumber);
                getLogger()
                    .i('userModelOrFailure from codeSent:$userModelOrFailure');
                userModelOrFailure.fold(
                  (AuthFailure failure) {
                    getLogger().e('failure:$failure');
                    _streamController.add(left(AuthUiLogicState.errorState(
                        state.userModel, failure, _controller)));
                    verificationCompleter.complete();
                  },
                  (UserModel userModel) {
                    getLogger().i('userModel:$userModel');
                    _streamController.add(right(userModel));
                    verificationCompleter.complete();
                  },
                );
              },
              codeAutoRetrievalTimeout: (String verificationId) {
                getLogger().i('codeAutoRetrievalTimeout :$verificationId');
              },
            );

            await verificationCompleter.future;

            await subscription.cancel();
          },
        );
      },
    );
  }

  void dispose() {
    _streamController.close();
  }

  void _startTimer(int initialSeconds) {
    _timer?.cancel();
    int secondsRemaining = initialSeconds;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining -= 1;
        if (state is _SecondStep) {
          add(_SmsCodeTimerTick(secondsRemaining));
        } else {
          _timer?.cancel();
          timer.cancel();
        }
      } else {
        _timer?.cancel();
        timer.cancel();
      }
    });
  }

  final StreamController<Either<AuthUiLogicState, UserModel>>
      _streamController = StreamController.broadcast();

  Stream<Either<AuthUiLogicState, UserModel>> get verificationStream =>
      _streamController.stream;

  final TextEditingController _controller = TextEditingController();

  final FirebaseAuth _firebaseAuth;

  final IAuthRepository _iAuthRepository;

  Timer? _timer;
}
