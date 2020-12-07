import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import 'hospital_image_client.dart';

class CompareHospitalAPIClient {
  //To Fetch Hospitals Name
  Dio dio;

  CompareHospitalAPIClient(this.dio);
  Future fetchImages(String name) async {
    FetchHospitalImages fetchHospitalImages = new FetchHospitalImages();
    return await fetchHospitalImages.fetchImagesFromGoogle(name);
  }
  
  Future fetchDataFromAssets(String stateName) async{
    final myData = await rootBundle.loadString("assets/compare_data.csv");
    List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(myData);
    // filter by state and the show list

    var filteredByState = rowsAsListOfValues.where((i) => i[2]== stateName).toList();
    filteredByState.forEach((element) {
      element.add(0);
    });
    return filteredByState; 
  }
  
}
