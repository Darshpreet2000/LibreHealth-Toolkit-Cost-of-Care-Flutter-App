import 'dart:async';

import 'package:curativecare/models/nearby_hospital.dart';
import 'package:curativecare/network/overpass_api_client.dart';
import 'package:curativecare/repository/abstract/nearby_hospitals_repository.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class NearbyHospitalsRepoImpl implements NearbyHospitalsRepository {
  @override
  Future fetch_hospitals() async {
    OverpassAPIClient overpassAPIClient = new OverpassAPIClient();
    return overpassAPIClient.fetch_nearby_hospitals();
  }

  @override
  Future<List<NearbyHospital>> parse_json(String responseBody) async {
    OverpassAPIClient overpassAPIClient = new OverpassAPIClient();
    return overpassAPIClient.parse_hospital_json_data(responseBody);
  }

  @override
  Future<String> fetchImages(String name) async {
    String url = 'https://www.google.com/search?tbm=isch&q=';
    url = url + "${name} Hospital";

    var response = await http.get(url);

    if (response.statusCode == 200) {
      String document = response.body;
      var doc = parse(document);
      var img = doc.getElementsByTagName('img')[1].attributes['src'];
      return img;
    } else {
      throw Exception('Failed to load');
    }
  }
}
