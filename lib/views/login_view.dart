// import 'dart:js_interop';
import 'package:flutter/material.dart';
// import 'dart:developer' as devtools show log;
import 'package:smartpen/constants/routes.dart';
import 'package:smartpen/services/auth/auth_exceptions.dart';
import 'package:smartpen/services/auth/auth_service.dart';
import 'package:smartpen/utilities/show_error_dialogue.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: const Text('Login'),
            ),
            body: Column(
            children: [
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: ' Enter your email'),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: ' and password, please'
                ),
              ),
              TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  try {
                  await AuthService.firebase().logIn(
                    email: email, 
                    password: password
                    );
                    final user = AuthService.firebase().currentUser;
                    if (user?.isEmailVerified ?? false ) {
                      // user's email is verified 
                      if (!context.mounted) return;
                      Navigator.of(context).pushNamedAndRemoveUntil(
                      notesRoute, 
                      (route) => false,
                      );
                    } else {
                      // user's email is not verified
                      if (!context.mounted) return;
                      Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyEmailRoute, 
                      (route) => false,
                      );
                    }
                  } on UserNotFoundAuthException {
                    if (!context.mounted) return; 
                    await showErrorDialogue(
                   context, 
                   'User not found',
                   );
                  } on WrongPasswordAuthException {
                    if (!context.mounted) return; 
                    await showErrorDialogue(
                   context, 
                   'Wrong credentials',
                   );
                  } on GenericAuthException {
                    if (!context.mounted) return; 
                    await showErrorDialogue(
                   context, 
                   'Authentication error',
                   );
                  }
                }, 
                child: const Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      registerRoute, 
                      (route) => false,
                      );
                  }, 
                  child: const Text('Not registered yet? Register here!'),
                  )
              ],
            ),
          );
        }
      }

  
