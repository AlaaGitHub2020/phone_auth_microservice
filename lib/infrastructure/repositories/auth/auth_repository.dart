import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:phone_auth_microservice/domain/core/utilities/constants.dart';
import 'package:phone_auth_microservice/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:phone_auth_microservice/domain/models/auth/auth_failure.dart';
import 'package:phone_auth_microservice/domain/models/auth/i_auth_repository.dart';
import 'package:phone_auth_microservice/domain/models/auth/user_model.dart';

///Authorization Repository
@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  AuthRepository(this._firebaseAuth, this._fireStore);

  ///FirebaseAuth instance
  final FirebaseAuth _firebaseAuth;

  ///FirebaseFireStore instance
  final FirebaseFirestore _fireStore;

  @override
  Future<Either<AuthFailure, UserModel>> verificationFailed(
      FirebaseAuthException firebaseAuthException) async {
    try {
      getLogger().e('FirebaseAuthException:$firebaseAuthException');

      if (firebaseAuthException.code == 'invalid-phone-number') {
        getLogger().e('invalid-phone-number');
        return left(const AuthFailure.invalidPhoneNumberFailure());
      } else if (firebaseAuthException.code == 'too-many-requests') {
        getLogger().e('too-many-requests.');
        return left(const AuthFailure.tooManyRequestsFailure());
      }

      return left(const AuthFailure.firebaseServerFailure());
    } on Exception catch (error) {
      getLogger().e('Exception Error:$error');
      return left(const AuthFailure.firebaseServerFailure());
    }
  }

  @override
  Future<Either<AuthFailure, UserModel>> createNewEmptyUser(
      {required User authorizedUser}) async {
    try {
      String userCollectionName = kReleaseMode
          ? DomainConstants.releaseUserCollection
          : DomainConstants.debugUserCollection;
      DocumentReference<Map<String, dynamic>> userDocRef = _fireStore
          .collection(userCollectionName)
          .doc(authorizedUser.phoneNumber);

      Map<String, dynamic> userMap = {
        'id': authorizedUser.uid,
        'phoneNumber': authorizedUser.phoneNumber,
        'emailAddress': authorizedUser.email,
        'photoUrl': authorizedUser.photoURL,
        'firstName': authorizedUser.displayName?.split(' ').elementAt(0) ?? '',
        'secondName': authorizedUser.displayName?.split(' ').elementAt(1) ?? '',
      };

      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await userDocRef.get();

      if (!snapshot.exists) {
        await userDocRef.set(userMap);
      }

      Either<AuthFailure, UserModel> updatedUser =
          await getUser(userNumber: authorizedUser.phoneNumber!);
      return updatedUser;
    } on Exception catch (error) {
      getLogger().e('Exception Error:$error');
      return left(const AuthFailure.firebaseServerFailure());
    }
  }

  @override
  Future<Either<AuthFailure, UserModel>> updateUser(
      {required UserModel userModel}) async {
    try {
      String userCollectionName = kReleaseMode
          ? DomainConstants.releaseUserCollection
          : DomainConstants.debugUserCollection;
      DocumentReference<Map<String, dynamic>> userDocRef =
          _fireStore.collection(userCollectionName).doc(userModel.phoneNumber);

      Map<String, dynamic> userMap = {
        'photoUrl': userModel.photoUrl,
        'firstName': userModel.firstName,
        'secondName': userModel.secondName,
      };

      await userDocRef.update(userMap);
      Either<AuthFailure, UserModel> updatedUser =
          await getUser(userNumber: userModel.phoneNumber);

      return updatedUser;
    } on Exception catch (error) {
      getLogger().e('Exception Error:$error');
      return left(const AuthFailure.firebaseServerFailure());
    }
  }

  @override
  Future<Either<AuthFailure, UserModel>> getUser(
      {required String userNumber}) async {
    try {
      String userCollectionName = kReleaseMode
          ? DomainConstants.releaseUserCollection
          : DomainConstants.debugUserCollection;
      DocumentReference<Map<String, dynamic>> userDocRef =
          _fireStore.collection(userCollectionName).doc(userNumber);

      UserModel updatedUser = UserModel.fromFireBase(await userDocRef.get());

      return right(updatedUser);
    } on Exception catch (error) {
      getLogger().e('Exception Error:$error');
      return left(const AuthFailure.fetchCurrentUserFailure());
    }
  }

  @override
  Future<Either<AuthFailure, UserModel>> signInWithCredential(
      String verificationId, String smsCode) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await _firebaseAuth.signInWithCredential(credential);

      final User? authorizedUser = _firebaseAuth.currentUser;
      getLogger().i('authorizedUser:$authorizedUser');

      if (authorizedUser != null) {
        Either<AuthFailure, UserModel> userModel =
            await createNewEmptyUser(authorizedUser: authorizedUser);

        return userModel;
      }
      return left(const AuthFailure.verificationNotCompleted());
    } on Exception catch (error) {
      getLogger().e('Exception Error:$error');
      return left(const AuthFailure.invalidPhoneNumberFailure());
    }
  }
}
