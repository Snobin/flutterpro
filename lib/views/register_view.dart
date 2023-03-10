import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: const Text("Register Here")
        ),
      body: Column(
        children: [
                      TextField(
                        controller: _email,
                        enableSuggestions: true,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            const InputDecoration(hintText: 'enter email here'),
                      ),
                      TextField(
                        controller: _password,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                            hintText: 'enter password here '),
                      ),
                      TextButton(
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;
                          try{
                              final userCredential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email,
                                  password: password);
                          print(userCredential);
                          } on FirebaseAuthException catch(e){
                            if(e.code=='weak-password')
                              print('weak password');
                            else if(e.code=='email-already-in-use')
                               print('email already in use');
                            else if(e.code=='invalid-email')
                               print('invalid email');
                            else if(e.code=='unknown')
                               print(' Enter credentials');
                           else 
                           {
                            print(e.code);
                           }
                          }
                          
                        },
                        child: const Text('Register'),
                      ),
                      TextButton(onPressed: 
                      (){Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login/', (route) => false);}, 
                      child: const Text("Already Registered, Login Here"),)
                    ]),
    );
  }
}
