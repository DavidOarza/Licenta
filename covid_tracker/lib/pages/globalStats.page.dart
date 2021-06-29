import 'package:flutter/material.dart';
import 'package:covid_tracker/widget/globalStatistics.dart';
import 'package:covid_tracker/covidService.dart';
import 'package:covid_tracker/models/globalSummary.dart';

CovidService covidService = CovidService();

class GlobalStatsPage extends StatefulWidget {
  @override
  _GlobalStatsPageState createState() => _GlobalStatsPageState();
}

class _GlobalStatsPageState extends State<GlobalStatsPage> {

  Future<GlobalSummaryModel> summary;

  @override
  void initState() {
    super.initState();
    summary = covidService.getGlobalSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        FutureBuilder(
          future: summary,
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Center(child: Text("Error"),);
            switch (snapshot.connectionState) {
              default:
                return !snapshot.hasData
                    ? Center(child: Text("Empty"),)
                    : GlobalStatistics(
                  summary: snapshot.data,
                );
            }
          },
        ),

      ],
    );
  }
}