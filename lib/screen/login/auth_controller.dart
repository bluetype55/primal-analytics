import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../app.dart';

class AuthController extends GetxController {
  Rx<User?> firebaseUser = Rx<User?>(null);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void onInit() {
    super.onInit();
    // 로그인 상태 변경 감지
    _auth.authStateChanges().listen((User? user) {
      firebaseUser.value = user;
    });
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (error) {
      print(error);
      return null;
    }
    return null;
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
    AppState().restartApp();
  }
}
