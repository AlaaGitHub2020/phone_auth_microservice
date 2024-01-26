import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_microservice/domain/models/auth/auth_failure.dart';
import 'package:phone_auth_microservice/domain/models/auth/user_model.dart';

///IAuth Repository
abstract class IAuthRepository {
  Future<Either<AuthFailure, UserModel>> verificationCompleted(
      PhoneAuthCredential phoneAuthCredential,
      String userPhoneNumber,
      TextEditingController pinController);

  Future<Either<AuthFailure, UserModel>> verificationFailed(
      FirebaseAuthException firebaseAuthException);

  Future<Either<AuthFailure, UserModel>> codeSent(String verificationId,
      int? resendToken, String? smsCode, String userPhoneNumber);

  Future<UserModel> createNewEmptyUser(String userPhoneNumber,
      {required User authorizedUser});
}
