import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/main.dart';
import 'package:finals/screens/Home_Ngo/home_ngo.dart';
import 'package:finals/services/ngo_dis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterNgo extends StatefulWidget {
  const RegisterNgo({super.key});

  @override
  State<RegisterNgo> createState() => _RegisterNgoState();
}

class _RegisterNgoState extends State<RegisterNgo> {
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _ngoName = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _city = TextEditingController();

  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email : _email.text.trim(),
      password : _password.text.trim(),
    );
  }
  @override
  void dispose(){
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _ngoName.dispose();
    _phone.dispose();
    super.dispose();
  }
  void col (){
    CollectionReference collRef = FirebaseFirestore.instance.collection('ngo');
    collRef.add({
      'name' : _ngoName.text,
      'email' : _email.text,
      'phone' : _phone.text,
      'password' : _password.text,
      'city' : _city.text,
    }).then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Harmony Share'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: OverflowBar(
              overflowSpacing: 20,
              children: [
                Text('Register Here',
                  style: TextStyle(
                      fontSize: 20.0,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold
                  ),
                ),

                TextFormField(
                  controller: _ngoName,
                  decoration: InputDecoration(
                      hintText: 'Enter NGO Name',
                      labelText: 'Name',
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.green,
                      ),
                      errorStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius:
                          BorderRadius.all(Radius.circular(9.0)))
                  ),
                ),

                TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                      hintText: 'Enter Email',
                      labelText: 'Email',
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.green,
                      ),
                      errorStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius:
                          BorderRadius.all(Radius.circular(9.0)))
                  ),
                ),

                TextFormField(
                  controller: _phone,
                  decoration: InputDecoration(
                      hintText: 'Enter Phone no.',
                      labelText: 'Phone no.',
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                      errorStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius:
                          BorderRadius.all(Radius.circular(9.0)))
                  ),
                ),


                TextFormField(
                  controller: _city,
                  decoration: InputDecoration(
                      hintText: 'Enter City',
                      labelText: 'City',
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                      errorStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius:
                          BorderRadius.all(Radius.circular(9.0)))
                  ),
                ),


                TextFormField(
                  obscureText: true,
                  controller: _password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter User Password";
                    } else if (value.length < 6) {
                      return "Password should be greater then 5 digit";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "Enter Password",
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

                // SizedBox(height: 20),
                TextFormField(
                  controller: _confirmPassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Confirm Password";
                    } else if (value.length < 6) {
                      return "Password should be greater then 5 digit";
                    } else if (value != _password.text) {
                      return "Confirm Password not matches with Password";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter your password again to confirm",
                    labelText: "Confirm password",
                    prefixIcon: Icon(Icons.password_sharp),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: (){
                      signUp();
                      col();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> NgoDisplay()));
                    },
                    child:Text("Register"),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}