import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get/get.dart';
import '../controllers/controller.dart';
import '../models/user_model.dart';
import 'database.dart';

final UserController c = Get.find();

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  User? _userFromFirebase(auth.User? user) {
    return User(uid: user!.uid);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> signIn(
    String email,
    String password,
  ) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      c.formValidateUser.text = "1";
      return _userFromFirebase(credential.user);
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
            "User Tidak Ditemukan", "Email yang dimasukkan belum terdaftar.");
        c.formValidateUser.text = "0";
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
            "Salah Password", "Periksa kembali password yang dimasukkan.");
        c.formValidateUser.text = "0";
      }
    } catch (e) {
      null;
    }
    return null;
  }

  Future<User?> signUp(String email, String password, String firstname,
      String lastname, String username) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      var uid = credential.user!.uid;
      if (user != null) {
        await DatabaseService(uid: uid)
            .setUserData(firstname, lastname, username, email);
      }
      return _userFromFirebase(credential.user);
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
            "Password Lemah", "Mohon gunakan password yang lebih kompleks.");
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Email Telah Terdaftar",
            "Mohon gunakan email yang berbeda untuk mendaftar.");
      }
    } catch (e) {
      null;
    }
    return null;
  }

  Future<User?> ubahPassword(String newPassword) async {
    try {
      await _firebaseAuth.currentUser?.updatePassword(newPassword);
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
            "Password Lemah", "Mohon gunakan password yang lebih kompleks.");
      }
    } catch (e) {
      null;
    }
    return null;
  }

  Future<void> signOff() async {
    c.cleanform();
    return await _firebaseAuth.signOut();
  }
}
