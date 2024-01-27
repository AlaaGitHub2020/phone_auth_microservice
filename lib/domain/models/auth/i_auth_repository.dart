import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_auth_microservice/domain/models/auth/auth_failure.dart';
import 'package:phone_auth_microservice/domain/models/auth/user_model.dart';

///IAuth Repository
abstract class IAuthRepository {
  Future<Either<AuthFailure, UserModel>> verificationFailed(
      FirebaseAuthException firebaseAuthException);

  Future<Either<AuthFailure, UserModel>> signInWithCredential(
      String verificationId, String smsCode);

  Future<Either<AuthFailure, UserModel>> createNewEmptyUser(
      {required User authorizedUser});

  Future<Either<AuthFailure, UserModel>> updateUser(
      {required UserModel userModel});

  Future<Either<AuthFailure, UserModel>> getUser({required String userNumber});
}
