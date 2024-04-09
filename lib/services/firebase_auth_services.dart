import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<User?> signUpwithEmailAndPassword(String email , String password) async {
  //   try {
  //     UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
  //     return credential.user;
  //   }
  //   on FirebaseAuthException catch(e){
  //
  //     if (e.code == 'email-already-in-use'){
  //       showToast(message: 'The Email Is Already in Use.');
  //     }
  //     else {
  //       showToast(message: 'Some Error Occured. ${e.code}');
  //     }
  //
  //   }
  //   return null;
  // }

  Future<User?> signInwithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      if (user != null) {
        String userId = user.uid;
        String name = user.displayName ?? ' ';// Define userId here
        //SessionController().userId = userId;
        //SessionController().name = name;// Use userId here
        return user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        //showToast(message: 'Invalid Email or Password.');
      } else {
        //showToast(message: 'Some Error Occured. ${e.code}');
      }
      return null;
    }
    return null;
  }

}