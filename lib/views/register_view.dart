import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'dart:developer' as devtools show log;
import 'package:smartpen/constants/routes.dart';
import 'package:smartpen/utilities/show_error_dialogue.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

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
            appBar: AppBar(title: const Text('Register'),),
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
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email, 
                    password: password
                    );
                    final user = FirebaseAuth.instance.currentUser;
                    await user?.sendEmailVerification();
                    Navigator.of(context).pushNamed(verifyEmailRoute);
                 } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    await showErrorDialogue(
                   context, 
                   'Weak password',
                   );
                  } else if (e.code == 'email-already-in-use') {
                    await showErrorDialogue(
                   context, 
                   'Email is already in use',
                   );
                  } else if (e.code == 'invalid-email') {
                    await showErrorDialogue(
                   context, 
                   'Invalid email',
                   );
                  } else {
                    await showErrorDialogue(
                   context, 
                   'Error ${e.code}',
                   );
                  }
                 } catch (e) {
                  await showErrorDialogue(
                   context, 
                   e.toString(),
                   );
                }
                },
                child: const Text('Register'),
                ),
                TextButton(onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute, 
                    (route) => false,
                    );
                }, 
                child: const Text('Already registered? Login here!')
                )
              ],
            ),
          );
        }
      }