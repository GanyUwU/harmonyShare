import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/database.dart';
import '../../services/firebase_auth_services.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();// initialize Flutter binding
  runApp(const MaterialApp(
    home: CreateAccount(),
  ));
}

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  bool _obscureText = true;
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _mobilenocontroller = TextEditingController();
  final TextEditingController _addresscontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _namecontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _addresscontroller.dispose();
    _mobilenocontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: const Text(
          "FitsClean",
          style: TextStyle(
            fontSize: 35.0,
            fontFamily: 'Roboto',
            fontStyle: FontStyle.italic,
              color: Colors.white
          ),
        ),
        centerTitle: true,
        leading: null,
      ),
      body:SingleChildScrollView(
      child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30, // Add this line to add space between the text fields
            ),
            const Text(
              "Create New Account",
              style: TextStyle(
                fontSize: 35.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20, // Add this line to add space between the text fields
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _namecontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: 'Name',
                  labelStyle: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                  ),
                  //prefixIcon: Icon(MdiIcons.account),
                ),
              ),
            ),
            const SizedBox(
              height: 20, // Add this line to add space between the text fields
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _mobilenocontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: 'Mobile Number',
                  labelStyle: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                  ),
                  //prefixIcon: Icon(MdiIcons.phone),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10), // Limit input to 10 characters
                ],
              ),
            ),
            const SizedBox(
              height: 20, // Add this line to add space between the text fields
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _addresscontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: 'Address & Pincode',
                  labelStyle: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                  ),
                  //prefixIcon: Icon(MdiIcons.mapMarker),
                ),
              ),
            ),
            const SizedBox(
              height: 20, // Add this line to add space between the text fields
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _emailcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: 'Email Address',
                  labelStyle: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                  ),
                  //prefixIcon: Icon(MdiIcons.email),
                ),
              ),
            ),
            const SizedBox(
              height: 20, // Add this line to add space between the text fields
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _passwordcontroller,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                  ),
                 // prefixIcon: Icon(MdiIcons.lock),
                 //  suffixIcon: IconButton(
                 //    icon: Icon(_obscureText ? MdiIcons.eyeOff : MdiIcons.eye),
                 //    onPressed: () {
                 //      setState(() {
                 //        _obscureText = !_obscureText;
                 //      });
                 //    },
                 //  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20, // Add this line to add space between the text fields
            ),
            SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: _signup,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    fixedSize: const Size(00, 48), // Set the width and height of the button here
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 22.0, // Increase the font size here
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
            ),
            const SizedBox(
              height: 20, // Add this line to add space between the text fields
            ),
            SizedBox(
                width: 300,
                child: OutlinedButton(
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const login()),
                    // );
                    // // Add your on pressed event here
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red[400], shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    fixedSize: const Size(00, 48), // Set the width and height of the button here
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 22.0, // Increase the font size here
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
      ),
    );
  }



  Future<void> createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailcontroller.text,
        password: _passwordcontroller.text,
      );
      User? user = userCredential.user;
      String? uid = user?.uid;
      String uidStr = uid ?? "";
      await DatabaseMethods().addUserDetails({
        //"Id": randomNumeric(10),
        "Name": _namecontroller.text,
        "Mobile No": _mobilenocontroller.text,
        "Address": _addresscontroller.text,
        "Email": _emailcontroller.text,
        "Password": _passwordcontroller.text,
        "UID": uidStr,
      }, uidStr);
    } catch (e) {
      print(e);
    }
  }

  void _signup() async {
    String email = _emailcontroller.text;
    String password = _passwordcontroller.text;


    // Validate password
    final RegExp hasNumber = RegExp(r'[0-9]');
    final RegExp hasUpperCase = RegExp(r'[A-Z]');
    final RegExp hasLowerCase = RegExp(r'[a-z]');
    final RegExp hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (password.length < 8 ||
        !hasNumber.hasMatch(password) ||
        !hasUpperCase.hasMatch(password) ||
        !hasLowerCase.hasMatch(password) ||
        !hasSpecialChar.hasMatch(password)) {
      //showToast(message: "Password must be at least 8 characters long and include at least one number, one uppercase letter, one lowercase letter, and one special character.");
      return;
    }

    // Validate email
    final RegExp emailRegex = RegExp(
        r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (!emailRegex.hasMatch(email)) {
      //showToast(message: "Please enter a valid email address.");
      return;
    }


    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        String uid = user.uid;
        await DatabaseMethods().addUserDetails({
          //"Id": randomNumeric(10),
          "Name": _namecontroller.text,
          "Mobile No": _mobilenocontroller.text,
          "Address": _addresscontroller.text,
          "Email": _emailcontroller.text,
          "Password": _passwordcontroller.text,
          "UID": uid,
        }, uid);
        //showToast(message:"User is Succesfully Created.");
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const login()),
        // );
      } else {
        //showToast(message:"User creation failed.");
      }
    }   on FirebaseAuthException catch(e){

      if (e.code == 'email-already-in-use'){
        //showToast(message: 'The Email Is Already in Use.');
      }
      else {
        //showToast(message: 'Some Error Occured. ${e.code}');
      }

    }
  }




}