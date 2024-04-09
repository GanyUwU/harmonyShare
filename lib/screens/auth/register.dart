import 'package:finals/main.dart';
import 'package:finals/screens/auth/session_mng.dart';
import 'package:finals/screens/auth/sign_in.dart';
import 'package:finals/screens/home/home.dart';
import 'package:finals/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final ref = FirebaseFirestore.instance.collection('Users').doc(SessionController().userId);
  String? userId = SessionController().userId;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final  _password = TextEditingController();
  final  _confirmPassword = TextEditingController();
  final  _firstName = TextEditingController();
  final  _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _pin = TextEditingController();

  @override
  void dispose(){
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _firstName.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email : _email.text.trim(),
      password : _password.text.trim(),
    );
  }
  Future<void> col()async {
    CollectionReference collRef = FirebaseFirestore.instance.collection('Users');
    collRef.add({
      'password' : _password.text,
      'email' : _email.text,
      'phone' : _phone.text,
      'name' : _firstName.text,
    }) .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
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
       child : Center(
        child: SingleChildScrollView(
         child: Padding(
           padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: OverflowBar(
              overflowSpacing: 20,
              children: [
                /*Image.asset(
                    'assets/donate.png',
                    // height: 200,
                    // width: 200,
                    fit:BoxFit.cover
                ),*/

                Text(
                  "Register Account",
                  style: TextStyle(
                      fontSize: 20.0,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold
                  ),
                ),

                TextFormField(
                 validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter User Name";
                        }
                        return null;
                      },
                  controller: _firstName,
                  decoration: InputDecoration(
                      hintText: 'Enter Your Name',
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
                /*
                TextFormField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Enter your phone no",
                    labelText: "Phone no",
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),*/
                // SizedBox(height: 20),
                TextFormField(
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
                /*
                TextFormField(
                  controller: _address,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    hintText: "Enter your address",
                    labelText: "Address",
                    prefixIcon: Icon(Icons.location_pin),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                // SizedBox(height: 20),
                TextFormField(
                  controller: _city,
                  decoration: InputDecoration(
                    hintText: "Enter the city you live in",
                    labelText: "City",
                    prefixIcon: Icon(Icons.location_city),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),*/
                // SizedBox(height: 20),
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
                // SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child:ElevatedButton(
                    onPressed: (){
                      signUp();
                      col();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> MyApp()));
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
                    child:isLoading
                        ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        )
                    )
                        :Text("Register"),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have a account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.amber,
                            decoration: TextDecoration.underline,
                          ),
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
     )
    )
    );
  }
}

