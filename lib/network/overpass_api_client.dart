import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:curativecare/models/hospitals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class OverpassAPIClient {
  String latitude;
  String radius = '15000';
  String longitude;
  String API_DOMAIN = "https://lz4.overpass-api.de/api/interpreter?data=";

  Future fetch_nearby_hospitals() async {
    if (box.containsKey('latitude') && box.containsKey('longitude')) {
      latitude = box.get('latitude');
      longitude = box.get('longitude');
      if (box.containsKey('radius')) {
        radius = box.get('radius');
        int radiusInt = int.parse(radius) * 1000;
        radius = radiusInt.toString(); //converting to metres
      }
      String Nearby_Hospitals =
          """[out:json];(node["amenity"="hospital"](around:$radius,$latitude,$longitude);way["amenity"="hospital"](around:$radius,$latitude,$longitude);relation["amenity"="hospital"](around:$radius,$latitude,$longitude););out center;""";
      print(API_DOMAIN + Nearby_Hospitals);
      try {
        final response = await http.get(API_DOMAIN + Nearby_Hospitals);
        print(response);
        return response;
      } on SocketException {
        http.Response response = new http.Response(" ", 400);

        return response;
      }
    }
  }

  Future<List<Hospitals>> parse_hospital_json_data(String responseBody) async {
    List<Hospitals> hospital_list = new List();
    latitude = box.get('latitude');
    longitude = box.get('longitude');
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

      Hospitals nearbyHospital =
          new Hospitals(name, path, distance.toString(), beds);
      hospital_list.add(nearbyHospital);
    }
    return hospital_list;
  }
}
