import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/main.dart';
import 'package:finals/screens/auth/option.dart';
import 'package:finals/screens/auth/register.dart';
import 'package:finals/screens/home/home.dart';
import 'package:finals/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'ForgotPassword.dart';
class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  signInWithEmailAndPassword() async{
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text,
          password: _password.text
      );
      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'user-not-found') {
          return showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                content: Text('No existing user found'),
              );
            },
          );

      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:
            Text("Wrong password provided for that user.")
          ),
        );
      }
      else{
        return ("correctly signed in");
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("HarmonyShare"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: OverflowBar(
                  overflowSpacing: 20,
                  children: [
                    Image.asset(
                      alignment: Alignment.center,
                        'assets/donate.png',
                          height: 200,
                          width: 300,
                        fit:BoxFit.cover
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Login to your User account",
                      style: TextStyle(
                          fontSize: 20.0,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _email,
                      validator: (text){
                        if(text == null || text.isEmpty){
                          return 'Email is empty';
                        }
                        if (!text.endsWith("@gmail.com")) {
                          return("Email address is not valid!");
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Enter your Email",
                          labelText: 'Email',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.green,
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                              BorderRadius.all(Radius.circular(9.0)))
                      ),
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _password,
                      validator: (text){
                        if(text == null || text.isEmpty){
                          return 'Password is empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Enter your Password",
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.green,
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                              BorderRadius.all(Radius.circular(9.0)))
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(right: 10.0) ,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return ForgotPasswordPage();
                            }));
                          },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.amber,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child:ElevatedButton(
                        onPressed: (){
                          if(_formKey.currentState !.validate()){
                            signInWithEmailAndPassword();
                            Navigator.push(
                            context,
                                MaterialPageRoute(builder: (context)=>Auth()));
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.amber),
                          foregroundColor: MaterialStateProperty.all(Colors.black),
                          textStyle: MaterialStateTextStyle.resolveWith((states) {
                            if(states.contains(MaterialState.pressed)) {
                              return TextStyle(fontSize: 20);
                            }
                            return TextStyle(fontSize: 15);
                          }),
                        ),
                        child: isLoading
                            ? Center(child: CircularProgressIndicator(
                          color: Colors.white,
                        )
                        )
                            : Text("Login"),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have a account?"),
                        TextButton(
                            onPressed: () {

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>Register()
                                  )
                              );
                            },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.amber,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
