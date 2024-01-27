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
import 'package:pinput/pinput.dart';

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
            add(const AuthUiLogicEvent.smsCodeFilled());
          },

          ///verifying Phone Number
          verifyingPhoneNumber: (_VerifyingPhoneNumber event) async {
            getLogger().i('verifyingPhoneNumber Started');
            if (_controller.text.isNotEmpty &&
                _controller.text.length == 6 &&
                _verificationId != null) {
              Either<AuthFailure, UserModel> userOrFailure =
                  await _iAuthRepository.signInWithCredential(
                      _verificationId!, _controller.text);
              userOrFailure.fold((AuthFailure failure) {
                getLogger().e('failure$failure');
                emit(AuthUiLogicState.errorState(
                    state.userModel, failure, _controller));
              }, (UserModel userModel) {
                getLogger().e('userModel $userModel');
                emit(AuthUiLogicState.authorizedUser(userModel));
              });
            } else {
              _controller.setText('');
            }
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
            getLogger().i('smsCodeTimerTick Started : ${_controller.text}');
            if (_controller.text.length == 6) {
              _timer?.cancel();
              emit(AuthUiLogicState.thirdStep(state.userModel));
              add(const AuthUiLogicEvent.verifyingPhoneNumber());

              return;
            }
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
                    add(const AuthUiLogicEvent.verifyingPhoneNumber());
                    verificationCompleter.complete();
                  },
                );
              },
            );
            await _firebaseAuth.verifyPhoneNumber(
              phoneNumber: state.userModel.phoneNumber,
              timeout: const Duration(seconds: 60),
              verificationCompleted:
                  (PhoneAuthCredential phoneAuthCredential) async {
                _controller.setText(phoneAuthCredential.smsCode!);
                Either<AuthFailure, UserModel> userModelOrFailure =
                    await _iAuthRepository.signInWithCredential(
                        phoneAuthCredential.signInMethod,
                        phoneAuthCredential.smsCode!);
                getLogger().i(
                    'userModelOrFailure from verificationCompleted:$userModelOrFailure');
                userModelOrFailure.fold(
                  (AuthFailure failure) {
                    getLogger().e('failure:$failure');
                    _streamController.add(left(AuthUiLogicState.errorState(
                        state.userModel, failure, _controller)));
                  },
                  (UserModel userModel) {
                    getLogger().i('userModel:$userModel');
                    _streamController.add(right(userModel));
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
                  },
                  (UserModel userModel) {
                    getLogger().i('userModel:$userModel');
                  },
                );
              },
              codeSent: (String verificationId, int? resendToken) async {
                _verificationId = verificationId;
                getLogger().i('resendToken :$resendToken');
                getLogger().i('verificationId :$verificationId');
                getLogger().i('_verificationId :$_verificationId');
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

  String? _verificationId;
}
