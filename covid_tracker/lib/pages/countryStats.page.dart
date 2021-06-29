import 'package:flutter/material.dart';

import 'package:covid_tracker/widget/countryStatistics.dart';

import 'package:covid_tracker/covidService.dart';

import 'package:covid_tracker/models/countrySummary.dart';
import 'package:covid_tracker/models/country.dart';

CovidService covidService = CovidService();

class CountryStatsPage extends StatefulWidget {
  @override
  _CountryStatsPageState createState() => _CountryStatsPageState();
}

class _CountryStatsPageState extends State<CountryStatsPage> {
  Future<List<CountryModel>> countryList;
  Future<List<CountrySummaryModel>> summaryList;

  @override
  initState() {
    super.initState();

    countryList = covidService.getCountryList();
    summaryList = covidService.getCountrySummary("romania");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: countryList,
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Center(
            child: Text("Error"),
          );
        switch (snapshot.connectionState) {
          default:
            return !snapshot.hasData
                ? Center(
                    child: Text("Empty"),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FutureBuilder(
                        future: summaryList,
                        builder: (context, snapshot) {
                          if (snapshot.hasError)
                            return Center(
                              child: Text("Error"),
                            );
                          switch (snapshot.connectionState) {
                            default:
                              return !snapshot.hasData
                                  ? Center(
                                      child: Text("Empty"),
                                    )
                                  : CountryStatistics(
                                      summaryList: snapshot.data,
                                    );
                          }
                        },
                      ),
                    ],
                  );
        }
      },
    );
  }
}
