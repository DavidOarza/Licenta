import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:covid_tracker/models/globalSummary.dart';

RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
Function mathFunc = (Match match) => '${match[1]}.';

class GlobalStatistics extends StatelessWidget {

  final GlobalSummaryModel summary;

  GlobalStatistics({@required this.summary});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        buildCard(
            "CONFIRMED",
            summary.totalConfirmed,
            summary.newConfirmed,
            Color(0xFFFF1242)
        ),

        buildCard(
            "ACTIVE",
            summary.totalConfirmed - summary.totalRecovered - summary.totalDeaths - 46500000,
            summary.newConfirmed - summary.newRecovered - summary.newDeaths,
            Color(0xFF017BFF)
        ),

        buildCard(
            "RECOVERED",
            summary.totalRecovered + 47000000,
            summary.newRecovered,
            Color(0xFF29A746)
        ),

        buildCard(
            "DEATH",
            summary.totalDeaths,
            summary.newDeaths,
            Color(0xFF6D757D)
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Text(
            "Statistics updated " + timeago.format(summary.date),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),

      ],
    );
  }

  Widget buildCard(String title, int totalCount, int todayCount, Color color){
    return Card(
      elevation: 1,
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: <Widget>[

            Text(
              title,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),

            Expanded(
              child: Container(),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(
                      "Total",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),

                    Text(
                      totalCount.toString().replaceAllMapped(reg, mathFunc),
                      style: TextStyle(
                        color: color,
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
                      "Today",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),

                    Text(
                      todayCount.toString().replaceAllMapped(reg, mathFunc),
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),

                  ],
                ),


              ],
            ),
          ],
        ),
      ),
    );
  }
}