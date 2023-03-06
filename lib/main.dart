import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note/firebase_options.dart';
import 'package:note/views/login_view.dart';
import 'package:note/views/register_view.dart';
import 'package:note/views/verifyemailview.dart';

//import 'package:note/views/register_view.dart';
// import 'dart:developer' as devtools show log;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
        '/notes/': (context) => const NotesView(),
      }));
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                print("ho");

                return const LoginView();
              } else {
                print(user);
                print("hello");
               //return const LoginView();
              return const VerifyEmail();
              }
            } else {
              return const VerifyEmail();
            }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

enum MenuAction { logout }

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main UI"),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showlogoutdial(context);
                  print(shouldLogout);
                  if (shouldLogout) {
                    await FirebaseAuth.instance.signOut();
                  }

                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/register/', (Route) => false);
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Log Out'),
                )
              ];
            },
          )
        ],
      ),
      body: const Text("hello "),
    );
  }
}

Future<bool> showlogoutdial(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign Out'),
        content: const Text("Are you sure"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/notes/', (route) => false);
              },
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login/', (route) => false);
              },
              child: const Text("Logout"))
        ],
      );
    },
  ).then((value) => value ?? false);
}
