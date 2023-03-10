import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title:const Text("Verify email here")),
      body: Column(
          children: [
          const Text('verify your email'),
          
          TextButton(
            onPressed: ()async{
             final user=FirebaseAuth.instance.currentUser; 
             print(user);
             await user?.sendEmailVerification();
            },
             child: const Text('send email'))
    
        ]),
        
    );
    
  }
}