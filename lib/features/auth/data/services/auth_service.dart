import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:restaurant/features/auth/data/models/user_model.dart';

class AuthService {
  // firebase auth instance oldik
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // google signin instance oldik
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;

  Future<AppUser?> googleAuthenticate() async {
    try {
      await googleSignIn.initialize(
        clientId:
            "410073535328-850gp47oqo33c2ls3cpm8te8v91smmd8.apps.googleusercontent.com",
        serverClientId:
            "410073535328-850gp47oqo33c2ls3cpm8te8v91smmd8.apps.googleusercontent.com",
      );

      final googleUser = await googleSignIn.authenticate();

      if (googleUser == null) {
        throw Exception("User cancelled sign in with Google");
      }

      final GoogleSignInAuthentication authentication =
          await googleUser.authentication;

      final googleCredential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(
        googleCredential,
      );

      final user = userCredential.user;
      if (user == null) return null;

      final appUser = AppUser(
        uid: user.uid,
        name: user.displayName ?? "",
        email: user.email ?? "",
      );
      await saveUserToFirestore(appUser);
      return appUser;
    } catch (e) {
      log("Google Sign-in Error: $e");
      throw Exception("Google Sign-in Error: $e");
    }
  }

  Future<UserCredential> signUpUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint(userCredential.toString());
      final user = userCredential.user;
      if (user != null) {
        final appUser = AppUser(
          uid: user.uid,
          name: "",
          email: user.email ?? "",
        );
        await saveUserToFirestore(appUser);
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      debugPrint(e.message.toString());
      throw Exception(e.message);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("$e");
    }
  }

  Future<void> logOutUser() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw Exception("$e");
    }
  }

  Future<UserCredential> signInUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> saveUserToFirestore(AppUser user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(user.toMap());
    } catch (e) {
      log("Firestore error: $e");
      throw Exception("Failed to save user to Firestore: $e");
    }
  }
}
