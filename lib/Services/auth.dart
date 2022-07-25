// ignore_for_file: missing_return

import 'package:medcare/Models/user_account_model.dart';

class AuthServices {
  late String userid;
  //UserCredential user;
  //DocumentSnapshot currentUserDoc;
  late UserModel currentUser;
  late String idToken;
}

getUser(String uid) async {}

// Create user authentication with email and password
// Firebase create document
Future<void> createUserDocument(
  String uid,
  String email,
) async {}
