import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future deleteUser(String email, String password) async {
    try {
      AuthCredential credentials =
          EmailAuthProvider.credential(email: email, password: password);
      print(currentUser);
      await currentUser!
          .reauthenticateWithCredential(credentials)
          .whenComplete(() async {
        await DatabaseService(uid: currentUser!.uid)
            .deleteuser(); // called from database class
        await currentUser!.delete();
        print('authentication completed');
      });
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future deleteuser() {
    return userCollection.doc(uid).delete();
  }
}
