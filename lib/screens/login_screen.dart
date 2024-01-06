import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:map_exam/common/models/models.dart';
import 'package:map_exam/common/router/router.gr.dart';
import 'package:map_exam/global.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _updateAuthState(UserCredential userCredential) {
    Global.authState.updateAuthData(
      userCredential.credential,
    );

    Global.authState.updateUserData(
      userCredential.user,
    );

    Global.authState.updateAdditionalData(
      userCredential.additionalUserInfo,
    );
  }

  void _initFirestoreSteam() {
    Global.noteStream = FirebaseFirestore.instance
        .collection('users')
        .doc(Global.authState.userData!.uid)
        .collection('notes')
        .snapshots()
        .listen(
      (QuerySnapshot<Map<String, dynamic>> snapshot) {
        List<Note> notes = snapshot.docs
            .map(
              (e) => Note.fromJson({
                ...e.data(),
                "id": e.id,
              }),
            )
            .toList();

        Global.noteProvider.updateNotes(notes);
      },
    );
  }

  Future<void> _login() async {
    if (_isLoading) {
      return;
    }

    setState(() {
      _isLoading = true;
    });
    try {
      UserCredential response =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _usernameController.text,
        password: _passwordController.text,
      );

      _updateAuthState(response);
      _initFirestoreSteam();

      context.router.replace(
        const HomeScreenRoute(),
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "User not found or invalid credentials.",
      );

      setState(() {
        _isLoading = false;
      });

      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Please sign in',
                style: TextStyle(fontSize: 35.0),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: 'Type your email here',
                ),
              ),
              TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Type your password',
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                child: Text(_isLoading ? 'Please wait...' : 'Sign in'),
                onPressed: _login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
