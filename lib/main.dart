import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smartpen/firebase_options.dart';
import 'package:smartpen/views/login_view.dart';
import 'package:smartpen/views/register_view.dart';


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
        '/login/': (context) => const LoginView(),
        '/register/':(context) => const RegisterView(),
      }
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) { // BuildContext used to pass data from one widget to the other
    return  FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // final user = FirebaseAuth.instance.currentUser;
              // if (user?.emailVerified ?? false) {  // we need to include situation when the user is null
                 // return const Text('Done'); 
              //} else {
              //  return const VerifyEmailView();
              // }
              return const LoginView();
          default: 
            return const CircularProgressIndicator();
          }
        },
      );
  }
}





