import 'dart:async';
import 'package:curativecare/models/hospitals.dart';
import 'package:curativecare/util/api_config.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import '../main.dart';

class OverpassAPIClient {
  String latitude;
  String radius = '15000';
  String longitude;
  Future fetch_nearby_hospitals() async {

    String nearbyHospitalApi=ApiConfig().nearbyHospitalApi;
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
      print(nearbyHospitalApi+ Nearby_Hospitals);
      try {
        Dio dio = new Dio();
        final response = await dio.get(nearbyHospitalApi + Nearby_Hospitals);
        print(response);
        return response;
      } on DioError catch (e) {
        if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
            DioErrorType.CONNECT_TIMEOUT == e.type) {
          throw Exception(
              "Please check your internet connection and try again");
        } else if (DioErrorType.DEFAULT == e.type) {
          if (e.message.contains('SocketException')) {
            throw Exception('No Internet Connection');
          }
        } else {
          throw Exception(
              "Problem connecting to the server. Please try again.");
        }
      }
    }
  }

  Future<List<Hospitals>> parse_hospital_json_data(
      Map<String, dynamic> responseBody) async {
    List<Hospitals> hospital_list = new List();
    latitude = box.get('latitude');
    longitude = box.get('longitude');
    Map<String, dynamic> parsedJson = (responseBody);
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
