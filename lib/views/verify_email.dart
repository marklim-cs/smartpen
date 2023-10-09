import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



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
            const Text('Please verify your email address:'),
            TextButton(onPressed: ()  async { // onPressed function is not marked as asynchronous 
              final user = FirebaseAuth.instance.currentUser; //we need the current user
              await user?.sendEmailVerification(); 
            }, 
            child: const Text('Send email verification') // child is preferred to be the last parametr
          )
        ],
      ),
    );
  }
}