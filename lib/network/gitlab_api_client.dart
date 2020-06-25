import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class GitLabApiClient {
  String base_url =
      "https://gitlab.com/api/v4/projects/18885282/repository/tree?ref=scrap-cdm-of-Indiana&path=CDM/";

  Future getAvailableCdm(String stateName) async {
    String url = base_url + stateName + "&per_page=100&page=";
    int i = 1;
    var response = await http.get(url + "1");
    Map<String, String> headers = response.headers;
    String responseBody = response.body;
    responseBody = responseBody.substring(
        responseBody.indexOf("[") + 1, responseBody.lastIndexOf("]"));
    String maxLen = headers["x-total-pages"];
    i++;
    while (i <= int.parse(maxLen)) {
      response = await http.get(url + i.toString());
      String currentResponse = response.body;
      currentResponse = currentResponse.substring(
          currentResponse.indexOf("[") + 1, currentResponse.lastIndexOf("]"));
      responseBody += "," + currentResponse;
      i++;
    }
    return "[" + responseBody + "]";
  }

  Future<List<String>> parseAvailableCdm(Future responseBody) async {
    var res = await responseBody;
    var elements = json.decode(res) as List;
    List<String> name = new List();
    for (int i = 0; i < elements.length; i++) {
      Map<String, dynamic> current_hospital = elements[i];
      String hospitalName = current_hospital['name'];
      hospitalName = hospitalName.substring(0, hospitalName.length - 4);
      name.add(hospitalName);
    }
    return name;
  }

  Future getCSVFile(String hospitalName,String stateName) async {
      String baseURL="https://gitlab.com/Darshpreet2000/lh-toolkit-cost-of-care-app-data-scraper/-/raw/scrap-cdm-of-Indiana/CDM";
      String url=baseURL+"/$stateName/$hospitalName"+".csv";
      var response = await http.get(url);
      print(response.body);
  }
}
