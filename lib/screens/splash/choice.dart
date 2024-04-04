// import 'package:finals/screens/auth/register.dart';
// import 'package:finals/screens/auth/sign_in.dart';
import 'package:finals/screens/auth/sign_in.dart';
import 'package:finals/screens/home/home.dart';
import 'package:flutter/material.dart';

class Choice extends StatelessWidget {
  const Choice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Harmony Share',
          style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w600 ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(80.0,100.0,70.0,30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 400,
              height: 100.0,
              child: TextButton(onPressed: (){},
                child: Text('Want to share?',
                  style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600 ),
                ),
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: BorderSide(color: Colors.red),
                    )
                ),
              ),
            ),
            SizedBox(height: 60),
            SizedBox(
              width: 400,
                height: 80.0,
                child:TextButton(onPressed: (){
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=> SignIn()),
                  );
                },
                  child:Row(
                    children: <Widget>[
                      Icon(Icons.account_balance),
                      SizedBox(width: 20),
                      Text("Food pickup and delivery",
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.black,fontSize: 14,fontWeight:FontWeight.w600, ),
                      ),
                    ], 
                  ),
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.red),

                      )
                  ),
                ),
            ),
        SizedBox(height: 40),
        SizedBox(
          width: 400,
        height: 80,
        child:TextButton(onPressed: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context)=> SignIn()),
          );
        },
          child:Row(
            children: <Widget>[
              Icon(Icons.account_circle_rounded),
              SizedBox(width: 15),
              Text("Donate your food to needy",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w600 ),
              ),
            ],
          ),
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Colors.red),

              )
          ),
        ),
      ),

          ],
        ),
      ),
    );
  }
}
