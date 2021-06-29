import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:covid_tracker/data.dart';
import 'package:covid_tracker/pages/quiz.dart';
import 'package:covid_tracker/pages/login.page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String grupa;
  Icon icon = Icon(Icons.notifications_none);

  getStudent() async {
    DocumentReference userRef = FirebaseFirestore.instance
        .doc("users/" + FirebaseAuth.instance.currentUser.uid);
    await userRef
        .get()
        .then((value) => {
              grupa = value['Grupa'].toString(),
            })
        .catchError((error) => print("Failed to add user: $error"));
  }

  checkCovid() async {
    await getStudent();
    CollectionReference userRef =
        FirebaseFirestore.instance.collection("users");
    await userRef
        .where('Grupa', isEqualTo: grupa)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                if (element['Covid'] == true) {
                  setState(() {
                    icon = Icon(
                      Icons.notification_important_outlined,
                      color: Colors.red,
                    );
                  });
                }
              })
            })
        .catchError((error) => print("Failed to add user: $error"));
  }

  // Future<void> _signOut() async {
  //   await FirebaseAuth.instance.signOut();
  // }

  buildCustomAppBar() {
    return AppBar(
      backgroundColor: Colors.lightBlueAccent,
      elevation: 0.0,
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
          //_signOut();
        },
        child: Icon(Icons.arrow_back, color: Colors.white),
      ),
      actions: <Widget>[
        IconButton(
          icon: icon,
          iconSize: 28.0,
          onPressed: () {
            if (icon.icon == Icons.notification_important_outlined) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                      'Cineva din grupa voastră are covid, vă rugăm izolați-vă!'),
                  duration: const Duration(milliseconds: 3000),
                  width: 280.0,
                  // Width of the SnackBar.
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    checkCovid();
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: buildCustomAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(screenHeight),
          _buildPreventionTips(screenHeight),
          _buildYourOwnTest(screenHeight),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildHeader(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'COVID-19',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Vă este rău?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Dacă vă simțiți rău, contactați imediat o persoană care vă poate ajuta',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
              ],
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildPreventionTips(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Sfaturi de prevenire',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: prevention
                  .map((e) => Column(
                        children: <Widget>[
                          Image.asset(
                            e.keys.first,
                            height: screenHeight * 0.12,
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Text(
                            e.values.first,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildYourOwnTest(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        padding: const EdgeInsets.all(10.0),
        height: screenHeight * 0.15,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey, Colors.lightBlueAccent],
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: FlatButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Quiz()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Fă-ți propriul test!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
