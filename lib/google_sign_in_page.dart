import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInPage extends StatefulWidget {
  @override
  _GoogleSignInPageState createState() => _GoogleSignInPageState();
}

class _GoogleSignInPageState extends State<GoogleSignInPage> {
  User? _user;

  Future<void> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) return; // người dùng cancel

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);

    setState(() {
      _user = userCredential.user;
    });
  }

  @override
  Widget build(BuildContext context) {
    // KHÔNG dùng Scaffold ở đây!
    return _user == null
        ? ElevatedButton(
      onPressed: signInWithGoogle,
      child: Text('Đăng nhập với Google'),
    )
        : Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(_user!.photoURL ?? ''),
          radius: 20,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Xin chào, ${_user!.displayName}!'),
            Text(_user!.email ?? ''),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                setState(() {
                  _user = null;
                });
              },
              child: Text('Đăng xuất'),
            )
          ],
        ),
      ],
    );
  }
}