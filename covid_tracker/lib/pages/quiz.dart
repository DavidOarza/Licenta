import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_tracker/pages/bottom.page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

var finalScore = 0;
var questionNumber = 0;
var quiz = new CovidQuiz();

class CovidQuiz{

  var questions = [
    "Ați avut febră sau frisoane în ultimele 48 de ore?",
    "Ați tușit în ultimele 48 de ore?",
    "Ați avut dificultăți de respirație în ultimele 48 de ore?",
    "Ați fost foarte obosit în ultimele 48 de ore?",
    "Ați avut dureri musculare sau corporale în ultimele 48 de ore?",
    "Ați avut dureri de cap în ultimele 48 de ore?",
    "Ați pierdut simțul gustului sau al mirosului în ultimele 48 de ore?",
    "Ați avut dureri de gât în ultimele 48 de ore?",
    "Ați avut greață în ultimele 48 de ore?",
  ];

  var choices = [
    ["Da", "Nu"],
    ["Da", "Nu"],
    ["Da", "Nu"],
    ["Da", "Nu"],
    ["Da", "Nu"],
    ["Da", "Nu"],
    ["Da", "Nu"],
    ["Da", "Nu"],
    ["Da", "Nu"],
    ["Da", "Nu"],
  ];

  var correctAnswers = [
    "Da", "Da", "Da", "Da", "Da", "Da", "Da", "Da", "Da", "Da"
  ];
}

class Quiz extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new QuizState();
  }
}

class QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: new Container(
            margin: const EdgeInsets.all(10.0),
            alignment: Alignment.topCenter,
            child: new Column(
              children: <Widget>[
                new Padding(padding: EdgeInsets.all(20.0)),

                new Container(
                  alignment: Alignment.centerRight,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      new Text("Întrebarea ${questionNumber + 1} din ${quiz.questions.length}",
                        style: new TextStyle(
                            fontSize: 22.0
                        ),),
                    ],
                  ),
                ),
                new Padding(padding: EdgeInsets.all(10.0)),

                new Text(quiz.questions[questionNumber],
                  style: new TextStyle(
                    fontSize: 20.0,
                  ),),

                new Padding(padding: EdgeInsets.all(10.0)),

                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //button 1
                    new MaterialButton(
                      minWidth: 120.0,
                      color: Colors.lightBlueAccent,
                      onPressed: (){
                        if(quiz.choices[questionNumber][0] == quiz.correctAnswers[questionNumber])
                          finalScore++;
                        updateQuestion();
                      },
                      child: new Text(quiz.choices[questionNumber][0],
                        style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.white
                        ),),
                    ),

                    //button 2
                    new MaterialButton(
                      minWidth: 120.0,
                      color: Colors.lightBlueAccent,
                      onPressed: (){

                        if(quiz.choices[questionNumber][1] == quiz.correctAnswers[questionNumber])
                          finalScore++;
                        updateQuestion();
                      },
                      child: new Text(quiz.choices[questionNumber][1],
                        style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.white
                        ),),
                    ),

                  ],
                ),

                new Padding(padding: EdgeInsets.all(15.0)),

                new Container(
                    alignment: Alignment.bottomCenter,
                    child:  new MaterialButton(
                        minWidth: 240.0,
                        height: 30.0,
                        color: Color(0xffff5757),
                        onPressed: resetQuiz,
                        child: new Text("Quit",
                          style: new TextStyle(
                              fontSize: 18.0,
                              color: Colors.white
                          ),)
                    )
                ),
              ],
            ),
          ),
        )
    );
  }

  void resetQuiz(){
    setState(() {
      Navigator.pop(context);
      finalScore = 0;
      questionNumber = 0;
    });
  }

  void updateQuestion(){
    setState(() {
      if(questionNumber == quiz.questions.length - 1){
        Navigator.push(context, new MaterialPageRoute(builder: (context)=> new Summary(score: finalScore,)));
      }else{
        questionNumber++;
      }
    });
  }
}

class Summary extends StatelessWidget{
  final int score;
  Summary({Key key, @required this.score}) : super(key: key);

  updateUser() async {
    DocumentReference userRef = FirebaseFirestore.instance
        .doc("users/" + FirebaseAuth.instance.currentUser.uid);
    await userRef
        .update({
      'Covid': true,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: new Container(
          margin: const EdgeInsets.all(30.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if(score<3)
                new Text("Felicitări, nu aveți covid",
                style: new TextStyle(
                    fontSize: 35.0
                ),),
              if(score>=3)

              new Text("Din păcate aveți covid",
              style: new TextStyle(
                  fontSize: 35.0
              ),),

              new Padding(padding: EdgeInsets.all(30.0)),

              new MaterialButton(
                color: Color(0xffff5757),
                onPressed: (){
                  if (score>= 3) updateUser();
                  questionNumber = 0;
                  finalScore = 0;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BottomNavScreen()));
                },
                child: new Text("Continuare",
                  style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.white
                  ),),)
            ],
          ),
        ),
      ),
    );
  }
}