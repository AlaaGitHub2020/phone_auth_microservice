import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:phone_auth_microservice/domain/core/utilities/constants.dart';
import 'package:phone_auth_microservice/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:phone_auth_microservice/domain/models/auth/auth_failure.dart';
import 'package:phone_auth_microservice/domain/models/auth/i_auth_repository.dart';
import 'package:phone_auth_microservice/domain/models/auth/user_model.dart';
import 'package:pinput/pinput.dart';

///Authorization Repository
@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  AuthRepository(this._firebaseAuth, this._fireStore);

  ///FirebaseAuth instance
  final FirebaseAuth _firebaseAuth;

  ///FirebaseFireStore instance
  final FirebaseFirestore _fireStore;

  @override
  Future<Either<AuthFailure, UserModel>> verificationCompleted(
      PhoneAuthCredential phoneAuthCredential,
      String userPhoneNumber,
      TextEditingController pinController) async {
    getLogger().i('phoneAuthCredential:$phoneAuthCredential');
    if (phoneAuthCredential.smsCode != null) {
      pinController.setText(phoneAuthCredential.smsCode!);

      await _firebaseAuth.signInWithCredential(phoneAuthCredential);

      final User? authorizedUser = _firebaseAuth.currentUser;
      getLogger().i('authorizedUser:$authorizedUser');

      if (authorizedUser != null) {
        Either<AuthFailure, UserModel> userModelOrFailure = right(UserModel(
            phoneNumber: authorizedUser.phoneNumber ?? '',
            firstName:
                (authorizedUser.displayName ?? '').split(' ').elementAt(0),
            secondName:
                (authorizedUser.displayName ?? '').split(' ').elementAt(1),
            emailAddress: authorizedUser.email ?? '',
            photoUrl: authorizedUser.photoURL ?? ''));
        return userModelOrFailure;
      }

      return right(UserModel.empty.copyWith(phoneNumber: userPhoneNumber));
    }

    return left(const AuthFailure.verificationNotCompleted());
  }

  @override
  Future<Either<AuthFailure, UserModel>> verificationFailed(
      FirebaseAuthException firebaseAuthException) async {
    getLogger().e('FirebaseAuthException:$firebaseAuthException');

    if (firebaseAuthException.code == 'invalid-phone-number') {
      getLogger().e('invalid-phone-number');
      return left(const AuthFailure.invalidPhoneNumberFailure());
    } else if (firebaseAuthException.code == 'too-many-requests') {
      getLogger().e('too-many-requests.');
      return left(const AuthFailure.tooManyRequestsFailure());
    }

    return left(const AuthFailure.firebaseServerFailure());
  }

  @override
  Future<Either<AuthFailure, UserModel>> codeSent(String verificationId,
      int? resendToken, String? smsCode, String userPhoneNumber) async {
    if (smsCode == null) {
      return left(const AuthFailure.waitingForSMSFailure());
    } else {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      await _firebaseAuth.signInWithCredential(credential);
      final User? authorizedUser = _firebaseAuth.currentUser;

      if (authorizedUser != null) {
        UserModel userModel = await createNewEmptyUser(userPhoneNumber,
            authorizedUser: authorizedUser);

        return right(userModel);
      }
      return left(const AuthFailure.firebaseServerFailure());
    }
  }

  @override
  Future<UserModel> createNewEmptyUser(String userPhoneNumber,
      {required User authorizedUser}) async {
    String userCollectionName = (!kReleaseMode)
        ? DomainConstants.releaseUserCollection
        : DomainConstants.debugUserCollection;
    DocumentReference<Map<String, dynamic>> userDocRef =
        _fireStore.collection(userCollectionName).doc(userPhoneNumber);

    Map<String, dynamic> userMap = {
      'id': authorizedUser.uid,
      'phoneNumber': authorizedUser.phoneNumber,
      'emailAddress': authorizedUser.email,
      'photoUrl': authorizedUser.photoURL,
      'firstName': authorizedUser.displayName,
      'secondName': authorizedUser.providerData.single.displayName,
    };

    await userDocRef.set(userMap);
    UserModel updatedUser = UserModel.fromFireBase(await userDocRef.get());

    return updatedUser;
  }
}
