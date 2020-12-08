import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:f_logs/model/flog/flog.dart';
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
    final myData = await rootBundle.loadString("assets/data.csv");

    FLog.info(
        className: "Real Data is ",
        methodName: "_buildRow1",
        text: myData.toString());
    List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(myData);
    // filter by state and the show list

    FLog.info(
        className: "Size ",
        methodName: "_buildRow1",
        text: " Size is "+ rowsAsListOfValues.length.toString());
    var filteredByState = rowsAsListOfValues.where((i) => i[2]== stateName).toList();

    filteredByState.forEach((element) {
      element.add(0);
    });
    FLog.info(
        className: "Filter ",
        methodName: "_buildRow1",
        text: " Size is "+ filteredByState.length.toString());

    return filteredByState;
  }
  
}
