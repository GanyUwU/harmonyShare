import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/Requests/ngo_req.dart';
import 'package:finals/maps/maps.dart';
import 'package:flutter/material.dart';
import '../Home_Ngo/profile_ngo.dart';
import '../auth/session_mng.dart';
import 'form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ref = FirebaseFirestore.instance.collection('Users').doc(SessionController().userId);
  String? userId = SessionController().userId;

  Widget allOrderDetails() {
    return StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection("ngo").where('rating', isGreaterThanOrEqualTo: '9').limit(2).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        return SizedBox(
          height: 350,
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<dynamic, dynamic> data = document.data()! as Map<dynamic, dynamic>;
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 7),
                          color: Colors.amber.withOpacity(.2),
                          spreadRadius: 2,
                          blurRadius: 10
                      )
                    ]
                ),
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(

                    onTap: () {
                      debugPrint('Card tapped.');
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePageNg()));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: ClipOval(
                                    child: Image.asset(
                                        'assets/ngo.png',
                                        height: 70,
                                        width: 60,
                                        fit:BoxFit.contain
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        const TextSpan(text: 'Name:\n'),
                                        TextSpan(text: data['name'] ?? 'N/A')
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            flex: 1,
                            child: Column(

                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        const TextSpan(text: 'City:\n'),
                                        TextSpan(text: data['city'] ?? 'N/A')
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 7),
                          color: Colors.amber.withOpacity(.2),
                          spreadRadius: 2,
                          blurRadius: 10
                      )
                    ]
                ),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("Share your love with donation"),
                        SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => FormD()));
                            },
                            child: Text("Donate")
                        ),

                      ],
                    ),
                    Image.asset(
                        'assets/donate.png',
                        height: 120,
                        width: 120,
                        fit:BoxFit.cover
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

             // REQUESTS

              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: Text(
                        "Requests",
                        style: TextStyle(
                            fontSize: 15.0,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  )
              ),

              /*
              SizedBox(height: 20),
              requests("hunger saviour", "Works for the betterment"),
              SizedBox(height: 20),
              requests("Anadan Kendra", "Efficient food donation! "),
              SizedBox(height: 20),
              requests("Snehawan", "Making lives live"),
              SizedBox(height: 20),
               */
              req(),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: Text(
                        "Top NGO's",
                        style: TextStyle(
                            fontSize: 15.0,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  )
              ),/*
              SizedBox(height: 20),
              top_ngos("NGO Name", "NGO Description"),
              SizedBox(height: 20),
              top_ngos("NGO Name", "NGO Description"),
              SizedBox(height: 20),
              top_ngos("NGO Name", "NGO Description"),
              SizedBox(height: 20),
              top_ngos("NGO Name", "NGO Description"),
              SizedBox(height: 20),
              top_ngos("NGO Name", "NGO Description"),
              */
              allOrderDetails(),


            ],
          ),
        ),
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MapScreen()));
        },
        // style: ButtonStyle(
        //   backgroundColor: MaterialStateProperty.all(Colors.amber),
        //   foregroundColor: MaterialStateProperty.all(Colors.black),
        //
        //   textStyle: MaterialStateTextStyle.resolveWith((states) {
        //     if(states.contains(MaterialState.pressed)) {
        //       return TextStyle(fontSize: 20);
        //     }
        //     return TextStyle(fontSize: 15);
        //   }),
        // ),
        child: Text("Map"),
      ),
    );
  }


  requests(String title, String subtitle) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 7),
                color: Colors.amber.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10
            )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: CircleAvatar(
          radius: 30,
          child: ClipOval(
            child: Image.asset('assets/donar.png'),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context)=>ReqAcceptedNgo())
              // );
            },
                icon: Icon(Icons.check),iconSize: 20),
            IconButton(onPressed: () {
              //deleteRequest();
              }, icon: Icon(Icons.close),iconSize: 20)
          ],
        ),
        tileColor: Colors.white,
      ),
    );
  }


  top_ngos(String subtitle) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 7),
                color: Colors.amber.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10
            )
          ]
      ),
      child: ListTile(
        title:allOrderDetails(),
        subtitle: Text(subtitle),
        leading: CircleAvatar(
          radius: 30,
          child: ClipOval(
            child: Image.asset('assets/ngo.png'),
          ),
        ),
        tileColor: Colors.white,
      ),
    );
  }
}

// String currentUserId = FirebaseAuth.instance.currentUser!.uid;
//
// Future<void> deleteRequest() async {
//   try {
//     final QuerySnapshot result = await FirebaseFirestore.instance.collection('form')
//         .where('userId', isEqualTo: 'E4Rvzqvmf3Q4ENVNUkAp0Dg0MN02')
//         .get();
//     final List<DocumentSnapshot> documents = result.docs;
//     for (DocumentSnapshot document in documents) {
//       await document.reference.delete();
//       print(result.docs);
//     }
//   } catch (e) {
//     print(e);
//   }
// }


Widget req() {
  return StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
    stream: FirebaseFirestore.instance
        .collection("Request").limit(2).snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
      if (!snapshot.hasData) {
        return const CircularProgressIndicator();
      }

      return SizedBox(
        height: 100,
        child: ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            Map<dynamic, dynamic> data = document.data()! as Map<dynamic, dynamic>;
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 7),
                        color: Colors.amber.withOpacity(.2),
                        spreadRadius: 2,
                        blurRadius: 10
                    )
                  ]
              ),
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Card(
                clipBehavior: Clip.hardEdge,
                child: InkWell(

                  onTap: () {
                    final String documentId = document.id;
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ReqAcceptedNgo(documentId: documentId)));
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: ClipOval(
                                  child: Image.asset(
                                      'assets/ngo.png',
                                      height: 70,
                                      width: 60,
                                      fit:BoxFit.contain
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Items:\n'),
                                      TextSpan(text: data['items'] ?? 'N/A')
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Column(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Quantity:\n'),
                                      TextSpan(text: data['quantity'] ?? 'N/A')
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

