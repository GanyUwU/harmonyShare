import 'package:finals/screens/splash/choice.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(40.0,250.0,30.0,40.0),
        margin: EdgeInsets.all(40.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children:<Widget> [
            Image.network('https://images.unsplash.com/photo-1511690656952-34342bb7c2f2?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              width: 400,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text("Harmony Share",
              style: TextStyle(
                  fontSize: 30.0),
              ),
            Text("Connecting People and Food",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,

              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => Choice()),
          );
        },
          child:
          Text('Next'),
      ),
    );
  }
}
