import 'package:flutter/material.dart';

import 'package:covid_tracker/models/countrySummary.dart';

RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
Function mathFunc = (Match match) => '${match[1]}.';

class CountryStatistics extends StatelessWidget {

  final List<CountrySummaryModel> summaryList;

  CountryStatistics({@required this.summaryList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        buildCard(
          "CONFIRMED",
          summaryList[summaryList.length - 1].confirmed,
          Color(0xFFFF1242),
          "ACTIVE",
          summaryList[summaryList.length - 1].active,
          Color(0xFF017BFF),
        ),

        buildCard(
          "RECOVERED",
          summaryList[summaryList.length - 1].recovered,
          Color(0xFF29A746),
          "DEATH",
          summaryList[summaryList.length - 1].death,
          Color(0xFF6D757D),
        ),
      ],
    );
  }

  Widget buildCard(String leftTitle, int leftValue, Color leftColor, String rightTitle, int rightValue, Color rightColor){
    return Card(
      elevation: 1,
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text(
                  leftTitle,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                Expanded(
                  child: Container(),
                ),

                Text(
                  "Total",
                  style: TextStyle(
                    color: leftColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),

                Text(
                  leftValue.toString().replaceAllMapped(reg, mathFunc),
                  style: TextStyle(
                    color: leftColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[

                Text(
                  rightTitle,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                Expanded(
                  child: Container(),
                ),

                Text(
                  "Total",
                  style: TextStyle(
                    color: rightColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),

                Text(
                  rightValue.toString().replaceAllMapped(reg, mathFunc),
                  style: TextStyle(
                    color: rightColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }


}