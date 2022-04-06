import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  //anonymous signin for guest
  Future<User?> getOrCreateAnoUser() async {
    try {
      if (currentUser == null) {
        await _firebaseAuth.signInAnonymously();
      }
      return currentUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //user sign in with email and password
  Future signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //register with password and email
  Future signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //sign out
  Future signOut() async {
    await _firebaseAuth.signOut();
    print('signout');
  }
}
