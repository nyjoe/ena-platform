// auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    var userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user;
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }

  Future<void> registerUser(String email, String password, String role) async {
    var userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _db.collection('users').doc(userCredential.user!.uid).set({
      'email': email,
      'role': role,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

   //Authentication with Google
  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await _auth.signInWithCredential(credential);
      
    } on Exception catch(e) {
      print('exception->$e');
    }
  }

  Future<String?> getUserRole(String uid) async {
    try {
      final doc = await _db.collection('roles').doc(uid).get();
      if (doc.exists) {
        return doc.data()?['role'] as String?;
      } else {
        throw Exception("Document inexistant !");
      }
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw Exception("Vous n'avez pas la permission d'accéder à ces données.");
      }
      throw Exception("Une erreur est survenue : ${e.message}");
    }
  }
}
