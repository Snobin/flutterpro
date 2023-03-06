import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _HomePageState();
}

class _HomePageState extends State<LoginView> {
  
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(title: const Text("Login here")),
     body: Column(children: [
                      TextField(
                        controller: _email,
                        enableSuggestions: true,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            const InputDecoration(hintText: 'Enter Email here'),
                      ),
                      TextField(
                        controller: _password,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                            hintText: 'Enter Password here '),
                      ),
                      TextButton(
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;
                          try{
                          
                            await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: email,
                                   password: password,
                                   );
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/notes/',
                                  (route) => false,
                                  );
                                  final use=FirebaseAuth.instance.currentUser;
                                  print(use);
                          }
                          on FirebaseAuthException catch(e){
                            if(e.code=='user-not-found')
                            {
                               print('user not found');
                            }else if(e.code=='wrong-password')
                            {
                              print('wrong password');
                            }else if(e.code=='invalid-email')
                               print('invalid email');
                               
                            else if(e.code=='unknown')
                            print('Enter credientials');   
                          }
                        },
                        child: const Text('Login'),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/register/',
                             (route) => false,
                             );
                        }, 
                      child:const Text("Not Registered yet? Register here!"),
                      ),
                     
                    ]),
   );
  }}