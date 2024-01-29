import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:primal_analytics/common/common.dart';

import '../../app.dart';
import '../dialog/d_message.dart';

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

  Future<void> deleteUserAccount() async {
    try {
      // 현재 로그인한 사용자 가져오기
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final String userId = user.uid;
        // Firestore에서 사용자 문서 삭제
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .delete();
        // Authentication에서 사용자 계정 삭제
        await user.delete();
        MessageDialog('회원탈퇴 완료').show();
        AppState().restartApp();
      }
    } on FirebaseAuthException catch (e) {
      MessageDialog('회원탈퇴 실패').show();
      print("계정 삭제 중 오류 발생: ${e.message}");
    }
  }

  Future<void> reauthenticateUser(String password) async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      User? user = FirebaseAuth.instance.currentUser;
      await user?.reauthenticateWithCredential(credential);
      final String userId = user!.uid;
      // Firestore에서 사용자 문서 삭제
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
      // Authentication에서 사용자 계정 삭제
      await user.delete();
      await signOut();
      MessageDialog('회원탈퇴 완료').show();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        // 비밀번호가 틀렸을 때의 처리
        MessageDialog('비밀번호가 잘못되었습니다.').show();
      } else {
        // 기타 FirebaseAuth 관련 오류 처리
        MessageDialog('회원탈퇴 실패: ${e.message}').show();
      }
    }
  }

  Future<String?> getPasswordFromUser(BuildContext context) async {
    String? password;
    // 비밀번호를 입력받기 위한 대화상자를 띄웁니다.
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('비밀번호 재확인'),
          content: TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: '비밀번호',
            ),
            onChanged: (value) {
              password = value;
            },
          ),
          actions: [
            TextButton(
              child: Text('취소'),
              onPressed: () {
                password = '';
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return password;
  }

  void showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('회원 탈퇴 확인'),
          content: Text("모든 회원정보가 삭제됩니다. 정말로 회원탈퇴 하시겠습니까?"),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // 대화상자 닫기
              },
            ),
            TextButton(
              child: Text('회원탈퇴',
                  style: TextStyle(color: context.appColors.allertText)),
              onPressed: () async {
                Navigator.of(dialogContext).pop(); // 대화상자 닫기
                String? password = await getPasswordFromUser(context);
                if (password != '' && password != null) {
                  await reauthenticateUser(password);
                } else {
                  MessageDialog('비밀번호를 입력하셔야 합니다.').show();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
