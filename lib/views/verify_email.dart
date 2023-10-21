import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartpen/constants/routes.dart';



class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  _VerifyEmailViewState createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (title: const Text('Verification')
      ),
      body: Column(
        children: [
            const Text("We've sent you an email verification. Please, open it to verify your account."),
            const Text("If you haven't received a verification email, press the button below"),
            TextButton(onPressed: ()  async { // onPressed function is not marked as asynchronous 
              final user = FirebaseAuth.instance.currentUser; //we need the current user
              await user?.sendEmailVerification(); 
            }, 
            child: const Text('Send email verification') // child is preferred to be the last parametr
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute, 
                (route) => false);
            }, 
            child: const Text ('Restart'),
            )
        ],
      ),
    );
  }
}