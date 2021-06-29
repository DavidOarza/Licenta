import 'package:covid_tracker/firebaseAuthentication.dart';
import 'package:flutter/material.dart';
import 'package:covid_tracker/widget/first.dart';
import 'package:covid_tracker/widget/textLogin.dart';

import 'bottom.page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuthHelper helper = FirebaseAuthHelper();
  String error = "";
  logIn() async{
    await helper.login(emailController.text, passwordController.text).then((value) => {
      setState(() {
        error = value;
      }),
      if(error == "") {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => BottomNavScreen())),
      }
    });
  }

  buildErrorMessage() {
    return Center(
      child: Text(error),
    );
  }
  buildOkButton(){
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 50, left: 200),
      child: Container(
        alignment: Alignment.bottomRight,
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blue[300],
              blurRadius: 10.0, // has the effect of softening the shadow
              spreadRadius: 1.0, // has the effect of extending the shadow
              offset: Offset(
                5.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: FlatButton(
          onPressed: () {
            logIn();

          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'OK',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.lightBlueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
  buildInputPassword(){
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: passwordController,
          style: TextStyle(
            color: Colors.white,
          ),
          obscureText: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Parola',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
  buildInputEmail(){
    return Padding(
    padding: const EdgeInsets.only(left: 50, right: 50),
    child: Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: emailController,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Colors.lightBlueAccent,
          labelText: 'E-mail',
          labelStyle: TextStyle(
            color: Colors.white70,
          ),
        ),
      ),
    ),
  );}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(children: <Widget>[
                  TextLogin(),
                ]),
                buildInputEmail(),
                buildInputPassword(),
                buildErrorMessage(),
                buildOkButton(),
                FirstTime(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


