import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:phone_auth_microservice/domain/core/utilities/constants.dart';

part 'user_model.freezed.dart';

part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String phoneNumber,
    String? firstName,
    String? secondName,
    String? emailAddress,
    String? photoUrl,
  }) = _UserModel;

  UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromFireBase(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    if (documentSnapshot.data() != null) {
      final Map<String, dynamic> userModelFromFireStoreObject =
          documentSnapshot.data()!;
      return UserModel.fromJson(userModelFromFireStoreObject);
    }
    return empty;
  }

  static UserModel get empty => UserModel(
        phoneNumber: '',
        firstName: '',
        secondName: '',
        emailAddress: '',
        photoUrl: '',
      );
}

/// Phone validator
extension PhoneValidator on String {
  /// Check if phone is valid
  bool isValidPhone() => RegExp(DomainConstants.phonePattern).hasMatch(this);
}
