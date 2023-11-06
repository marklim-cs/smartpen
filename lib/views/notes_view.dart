import 'package:flutter/material.dart';
import 'package:smartpen/constants/routes.dart';
import 'package:smartpen/enums/menu_action.dart';
import 'package:smartpen/services/auth/auth_service.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  get devtools => null;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected:(value) async {
              switch (value) {
                case MenuAction.logout:
                final shouldLogOut = await showLogOutDialog(context);
                devtools.log(shouldLogOut.toString());
                if (shouldLogOut) {
                  await AuthService.firebase().logOut();
                  //if (!context.mounted) return; 
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute, 
                    (_) => false,
                    );
                }
              }
           
          }, 
          itemBuilder: (context) {
            return const [
              PopupMenuItem<MenuAction>(
              value: MenuAction.logout, 
              child: Text('Log out'),
              )
            ];
            
          },)
        ],
      ),
      body: const Text('Hello world'),
    );
  }
}

  Future<bool>showLogOutDialog(BuildContext context) {
    return showDialog<bool>(
    context: context, 
    builder: (context) {
      return  AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(onPressed: () {
            Navigator.of(context).pop(false);
          }, 
          child: const Text('Cancel')),
          TextButton(onPressed: () {
            Navigator.of(context).pop(true);
          }, 
          child: const Text('Log out')),
        ],
      );
    },
    ).then((value) => value ?? false);
  }