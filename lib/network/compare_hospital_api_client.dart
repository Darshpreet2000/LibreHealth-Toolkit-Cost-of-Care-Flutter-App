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

  Future fetchDataFromAssets(String stateName) async {
    final myData = await rootBundle.loadString("assets/compare_data.csv");
    List<dynamic> myDataList = myData.split("\n");
    List<List<dynamic>> rowsAsListOfValues = new List();
    myDataList.forEach((element) {
      List<dynamic> values = new List();
      element.split(",").forEach((elementValue) {
        values.add(elementValue);
      });

      if (values.length > 2 && values[2] == stateName) {
        values.add(0);
        rowsAsListOfValues.add(values);
      }
    });

    // filter by state and the show list
    return rowsAsListOfValues;
  }
}
