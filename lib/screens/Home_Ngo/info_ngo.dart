
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../maps/maps.dart';
import '../Home_Ngo/profile_ngo.dart';
import '../auth/session_mng.dart';

class InfoNgo extends StatefulWidget {
  const InfoNgo({super.key});

  @override
  State<InfoNgo> createState() => _InfoState();
}

class _InfoState extends State<InfoNgo> {
  String? userId = SessionController().userId;

  Widget details() {
    return StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection("ngo").where('rating' , isGreaterThanOrEqualTo: '9').snapshots(),
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
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>UserInformation()));
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
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[

              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Top NGO's",
                    style: TextStyle(
                        fontSize: 15.0,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),/*
              SizedBox(height: 20),
              top_ngos("NGO Name", "NGO Description"),
              SizedBox(height: 20),
              top_ngos("NGO Name", "NGO Description"),
              SizedBox(height: 20),
              top_ngos("NGO Name", "NGO Description"),
              SizedBox(height: 20),
              */
              details(),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Top Donor's",
                    style: TextStyle(
                        fontSize: 15.0,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),/*
              SizedBox(height: 20),
              top_donors("Donor Name", "Donor Description"),
              SizedBox(height: 20),
              top_donors("Donor Name", "Donor Description"),
              SizedBox(height: 20),
              top_donors("Donor Name", "Donor Description"),
              SizedBox(height: 30),*/
              detailsDonor(),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: Text(
                        "Why you should donate food?",
                        style: TextStyle(
                            fontSize: 15.0,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  )
              ),

              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.circle,size: 10),
                      minLeadingWidth: 5,
                      minVerticalPadding: 5,
                      subtitle: Text("Nourishing Lives : Food donations serve as a lifeline, providing sustenance to those who struggle to access nutritious meals."),
                    ),
                    ListTile(
                      leading: Icon(Icons.circle,size: 10),
                      minLeadingWidth: 5,
                      minVerticalPadding: 5,
                      subtitle: Text("Combating Hunger : They contribute to the ongoing battle against hunger and malnutrition, making a tangible difference in the lives of individuals facing food insecurity."),
                    ),
                    ListTile(
                      leading: Icon(Icons.circle,size: 10),
                      minLeadingWidth: 5,
                      minVerticalPadding: 5,
                      subtitle: Text("Promoting Well-being : Access to regular meals is crucial for maintaining good health and well-being, particularly for vulnerable populations."),
                    ),
                    ListTile(
                      leading: Icon(Icons.circle,size: 10),
                      minLeadingWidth: 5,
                      minVerticalPadding: 5,
                      subtitle: Text("Fostering Solidarity : The act of donating food fosters a sense of community and solidarity, encouraging collective efforts to address food scarcity and support those in need."),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: Text(
                        "Benefits of donating food",
                        style: TextStyle(
                            fontSize: 15.0,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  )
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.circle,size: 10),
                      minLeadingWidth: 5,
                      minVerticalPadding: 5,
                      subtitle: Text("Reducing Food Waste : Donating surplus food reduces food waste, which helps in conserving resources, minimizing environmental impact, and contributing to sustainability efforts."),
                    ),
                    ListTile(
                      leading: Icon(Icons.circle,size: 10),
                      minLeadingWidth: 5,
                      minVerticalPadding: 5,
                      subtitle: Text("Healthier Communities : Access to nutritious food through donations contributes to healthier communities, reducing hunger-related health issues and improving overall well-being."),
                    ),
                    ListTile(
                      leading: Icon(Icons.circle,size: 10),
                      minLeadingWidth: 5,
                      minVerticalPadding: 5,
                      subtitle: Text("PSupporting Those in Need : Donated food helps provide meals to individuals and families facing food insecurity, ensuring they have access to nutritious food."),
                    ),
                    ListTile(
                      leading: Icon(Icons.circle,size: 10),
                      minLeadingWidth: 5,
                      minVerticalPadding: 5,
                      subtitle: Text("Tax Benefits : In many countries, individuals and businesses can receive tax benefits or deductions for donating food to qualified charitable organizations, encouraging charitable giving."),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  top_ngos(String title, String subtitle) {
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
            child: Image.asset('assets/ngo.png'),
          ),
        ),
        tileColor: Colors.white,
      ),
    );
  }

  top_donors(String title, String subtitle) {
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
        tileColor: Colors.white,
      ),
    );
  }
}

Widget detailsDonor() {
  return StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
    stream: FirebaseFirestore.instance
        .collection("Users").limit(4).snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
      if (!snapshot.hasData) {
        return const CircularProgressIndicator();
      }

      return SizedBox(
        height: MediaQuery.of(context).size.height,
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
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>UserInformation()));
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
                                      'assets/donar.png',
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