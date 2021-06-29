import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}
class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(color: Colors.lightBlueAccent),
      //margin: const EdgeInsets.all(10.0),
      child: Center(
        child: Text(
          'Principalele simptome includ: \n - Febră \n - Tuse \n - Respirație scurtă \n - Probleme de respirație\n - Oboseală\n - Frisoane, uneori cu tremurături\n - Dureri de corp\n - Durere de cap\n - Durere de gât\n - Congestie\n - Pierderea mirosului sau a gustului\n - Greață\n',
          textDirection: TextDirection.ltr,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
  }
