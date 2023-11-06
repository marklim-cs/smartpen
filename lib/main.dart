import 'package:flutter/material.dart';
import 'package:smartpen/constants/routes.dart';
import 'package:smartpen/services/auth/auth_service.dart';
import 'package:smartpen/views/login_view.dart';
import 'package:smartpen/views/notes_view.dart';
import 'package:smartpen/views/register_view.dart';
import 'package:smartpen/views/verify_email.dart';
//import 'dart:developer' as devtools show log;


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(), // the page it returns
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute:(context) => const RegisterView(),
        notesRoute:(context) => const NotesView(),
        verifyEmailRoute:(context) => const VerifyEmailView(),
      }
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) { // BuildContext used to pass data from one widget to the other
    return  FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                if (user.isEmailVerified) { 
                 return const NotesView();
                } else {
                  return const VerifyEmailView();
               }
             } else {
              return const LoginView();
              }
          default: 
            return const CircularProgressIndicator();
          }
        },
      );
  }
}



