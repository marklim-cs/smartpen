import 'package:flutter/material.dart';
//import 'dart:developer' as devtools show log;
import 'package:smartpen/constants/routes.dart';
import 'package:smartpen/services/auth/auth_exceptions.dart';
import 'package:smartpen/services/auth/auth_service.dart';
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
                    await AuthService.firebase().createUser(
                      email: email, 
                      password: password
                      );
                    AuthService.firebase().sendEmailVerification();
                    if (!context.mounted) return; 
                    Navigator.of(context).pushNamed(verifyEmailRoute);
                 } on WeakPasswordAuthException{
                  if (!context.mounted) return; 
                  await showErrorDialogue(
                   context, 
                   'Weak password',
                   );
                 } on EmailAlreadyInUseAuthException {
                  if (!context.mounted) return; 
                  await showErrorDialogue(
                   context, 
                   'Email is already in use',
                   );
                 } on InvalidEmailAuthException {
                  if (!context.mounted) return; 
                  await showErrorDialogue(
                   context, 
                   'Invalid email',
                   );
                 } on GenericAuthException {
                  if (!context.mounted) return; 
                  await showErrorDialogue(
                   context, 
                   'Failed to register',
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