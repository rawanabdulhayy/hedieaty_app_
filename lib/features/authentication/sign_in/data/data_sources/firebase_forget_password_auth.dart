import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordAuthService {
  final FirebaseAuth _authForget = FirebaseAuth.instance;
  // Forgot password method
  Future<void> sendPasswordResetEmail({required String email}) async {
    await _authForget.sendPasswordResetEmail(email: email);
  }
}
