import 'package:finals/main.dart';
import 'package:finals/screens/auth/sign_in.dart';
import 'package:finals/screens/home/home.dart';
import 'package:finals/services/signin_op.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          else{
            if(snapshot.hasData){
              return MyApp();
            }
            else{
              return Option_s();
            }
          }
        },
      ),
    );
  }
}

