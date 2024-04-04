import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _email = TextEditingController();

   Future passwordReset() async{
   try{
     await FirebaseAuth.instance.sendPasswordResetEmail(
         email: _email.text.trim());
     showDialog(
         context: context,
         builder: (context){
           return AlertDialog(
             content: Text('Password reset link sent'),
           );
          },
         );
   } on FirebaseAuthException catch(e){
     print(e);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(e.message.toString()),
        );
        });
     }
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Enter email for password reset link',
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: TextFormField(
                controller: _email,
                validator: (text){
                  if(text == null || text.isEmpty){
                    return 'Email is empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Email",
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.mail,
                      color: Colors.green,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius:
                        BorderRadius.all(Radius.circular(9.0)))
                ),
              ),
            ),
            SizedBox(height: 10.0),
            MaterialButton(
              onPressed: passwordReset,
              color: Colors.amber,
              child: Text('Reset Password'),
            )
        ]
      ),
    );
  }
}
