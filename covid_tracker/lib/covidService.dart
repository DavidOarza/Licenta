import 'dart:core';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:covid_tracker/models/globalSummary.dart';
import 'package:covid_tracker/models/countrySummary.dart';
import 'package:covid_tracker/models/country.dart';

class CovidService {
  Future<GlobalSummaryModel> getGlobalSummary() async {
    Uri myUri = Uri.parse("https://api.covid19api.com/summary");
    final data = await http.Client().get(myUri);

    //if (data.statusCode != 200) throw Exception();

    // GlobalSummaryModel summary =
    //     new GlobalSummaryModel.fromJson(json.decode(data.body));

    GlobalSummaryModel summary = GlobalSummaryModel(
      366160,
      177682872,
      8916,
      3851268,
      306386,
      115937280,
      DateTime.now(),
    );

    return summary;
  }

  Future<List<CountrySummaryModel>> getCountrySummary(String slug) async {
    Uri myUri =
        Uri.parse("https://api.covid19api.com/total/dayone/country/" + slug);
    final data = await http.Client().get(myUri);

    // if (data.statusCode != 200) {
    //   throw Exception();
    // }
    //
    // List<CountrySummaryModel> summaryList = (json.decode(data.body) as List)
    //     .map((item) => new CountrySummaryModel.fromJson(item))
    //     .toList();

    List<CountrySummaryModel> summaryList = [];

    summaryList.add(
      CountrySummaryModel(
        'Romania',
        1080282,
        32391,
        1045207,
        2684,
        DateTime.now(),
      ),
    );

    return summaryList;
  }

  Future<List<CountryModel>> getCountryList() async {
    Uri myUri = Uri.parse("https://api.covid19api.com/countries");
    final data = await http.Client().get(myUri);

    //if (data.statusCode != 200) throw Exception();

    // List<CountryModel> countries = (json.decode(data.body) as List)
    //     .map((item) => new CountryModel.fromJson(item))
    //     .toList();

    List<CountryModel> countries = [];

    countries.add(
      CountryModel(
        'Romania',
        'Slug',
        'Iso2',
      ),
    );

    return countries;
  }
}
