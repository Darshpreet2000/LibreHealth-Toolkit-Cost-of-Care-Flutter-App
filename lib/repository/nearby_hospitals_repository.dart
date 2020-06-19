import 'dart:async';
import 'dart:convert';
import 'package:curativecare/models/nearby_hospital.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// To find Nearby Hospitals using coordinates
abstract class NearbyHospitalsRepository {
  Future fetch_hospitals(); // To get Data of Nearby Hospitals  using Overpass API
  Future<List<NearbyHospital>> parse_json(String responseBody); //To Parse Json Data & convert it to List
  //Future<String> fetchImages(String name);

  }

class NearbyHospitals_Repository implements NearbyHospitalsRepository {
  SharedPreferences prefs;
  String latitude;
  String radius = '3000';
  String longitude;
  String API_DOMAIN = "https://lz4.overpass-api.de/api/interpreter?data=";
  String url='https://www.google.com/search?tbm=isch&q=';

  @override
  Future fetch_hospitals() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('latitude') && prefs.containsKey('longitude')) {
      latitude = prefs.getString('latitude');
      longitude = prefs.getString('longitude');

      String Nearby_Hospitals =
          """[out:json];(node["amenity"="hospital"](around:$radius,$latitude,$longitude);way["amenity"="hospital"](around:$radius,$latitude,$longitude);relation["amenity"="hospital"](around:$radius,$latitude,$longitude););out center;""";
      print(API_DOMAIN + Nearby_Hospitals);
      final response = await http.get(API_DOMAIN + Nearby_Hospitals);
      print(response);
      return response;
    }
  }

  @override
  Future<List<NearbyHospital>> parse_json(String responseBody) async {
    List<NearbyHospital> hospital_list = new List();
    Map<String, dynamic> parsedJson = json.decode(responseBody);
    var elements = parsedJson['elements'] as List;
    for (int i = 0; i < elements.length; i++) {
      String name, operator, beds, lat, lon;
      Future<String> path;
      double distance;
      Map<String, dynamic> current_hospital = elements[i];
      if (current_hospital.containsKey('center')) {
        Map<String, dynamic> center = current_hospital['center'];
        lat = center['lat'].toString();
        lon = center['lon'].toString();
      } else {
        lat = current_hospital['lat'].toString();
        lon = current_hospital['lon'].toString();
      }
      distance = await Geolocator().distanceBetween(double.parse(latitude),
              double.parse(longitude), double.parse(lat), double.parse(lon)) /
          1000;
      distance = num.parse(distance.toStringAsFixed(2));
      Map<String, dynamic> tags = current_hospital['tags'];
      name = tags['name'];
      if (name == null) name = 'N/A';
      operator = tags['operator'];
      if (operator == null) {
        operator = 'N/A';
      }
      beds = tags['beds'];
      if (beds == null) {
        beds = 'N/A';
      }

      NearbyHospital nearbyHospital =
          new NearbyHospital(name, path, distance.toString(), beds);
      hospital_list.add(nearbyHospital);
    }
    return hospital_list;
  }

}
