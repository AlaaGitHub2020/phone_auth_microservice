import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

///Infrastructure Injectable Module
@module
abstract class InfrastructureInjectableModule {
  ///firebase Auth instance
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  ///Firebase FireStore instance
  @lazySingleton
  FirebaseFirestore get fireStore => FirebaseFirestore.instance;

  ///Firebase FireStore instance
  @lazySingleton
  ImagePicker get picker => ImagePicker();
}
