import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        // color: Colors.amber,
        width: size.width,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              "Welcome Login to \nyou`r Todo",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 34,
            ),
            FilledButton.tonalIcon(
              style: FilledButton.styleFrom(
                fixedSize: Size(size.width, 48),
              ),
              onPressed: signInWithGoogle,
              label: const Text(
                "Login",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              ),
              icon: const Icon(Icons.golf_course),
            ),
          ],
        ),
      ),
    );
  }
}
