import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/screens/Home_Ngo/home_ngo.dart';
import 'package:flutter/material.dart';

class RegisterNgo extends StatefulWidget {
  const RegisterNgo({super.key});

  @override
  State<RegisterNgo> createState() => _RegisterNgoState();
}

class _RegisterNgoState extends State<RegisterNgo> {
  final _email = TextEditingController();
  final _name = TextEditingController();
  final _phone = TextEditingController();

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
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _name,
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
                SizedBox(height: 20.0),
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
                SizedBox(height: 20.0),
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
                SizedBox(height: 20.0),
                ElevatedButton(
                    onPressed: (){
                      CollectionReference collRef = FirebaseFirestore.instance.collection('ngo');
                      collRef.add({
                        'name' : _name.text,
                        'email' : _email.text,
                        'phone' : _phone.text,
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> HomeNgo()));
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