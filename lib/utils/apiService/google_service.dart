import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn( serverClientId: "556993160670-mb0ek9ukp41t6402t61vkktpmek415qe.apps.googleusercontent.com",
    clientId: "556993160670-o4cv647m8768qdoqp9od19egqgaq9rcb.apps.googleusercontent.com", 
    scopes: ['email', 'profile', 'openid'],
  );

  static Future<GoogleSignInAccount?> signIn() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      
      return account;
    } catch (error) {
      log("Google Sign-In Error: $error");
      return null;
    }
  }

  static Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_identity_services_web/google_identity_services_web.dart'; // Only for Web

// class FirebaseAuthService {
//   static final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Sign in with Google using Firebase directly
//   static Future<User?> signInWithGoogle() async {
//     try {
//       // Trigger the Google authentication process
//       final GoogleAuthProvider googleProvider = GoogleAuthProvider();

//       if (kIsWeb) {
//         // For Web authentication
//         return (await _auth.signInWithPopup(googleProvider)).user;
//       } else {
//         // For Android/iOS
//         return (await _auth.signInWithProvider(googleProvider)).user;
//       }
//     } catch (e) {
//       print("Error during Google Sign-In: $e");
//       return null;
//     }
//   }

//   // Sign out from Firebase
//   static Future<void> signOut() async {
//     await _auth.signOut();
//   }
// }
