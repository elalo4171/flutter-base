import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirebaseAuthService {
  FirebaseAuthService(this.firebaseAuth);
  final FirebaseAuth firebaseAuth;
  Future<void> signInWithPhoneNumber(
    String phoneNumber,
    void Function(String, int?) codeSent,
    void Function(PhoneAuthCredential) verificationCompleted,
  ) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: codeSent,
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  //Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final user = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user;
  }

  Future<UserCredential?> validateCode(
    String verificationId,
    String code,
  ) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: code,
    );
    final user = await firebaseAuth.signInWithCredential(credential);
    // final token = await firebaseAuth.currentUser?.getIdToken();
    return user;
  }

  //Get token from firebase
  Future<String?> getToken() async {
    return await firebaseAuth.currentUser?.getIdToken();
  }

  void signOut() {
    firebaseAuth.signOut();
  }
}
