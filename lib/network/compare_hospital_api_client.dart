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
    List<dynamic> myDataList=myData.split("\n");
    List<List<dynamic>> rowsAsListOfValues=new List();
    myDataList.forEach((element) {
      List<dynamic> values=element.split(",");
      rowsAsListOfValues.add(values);
    });

    // filter by state and the show list

     var filteredByState = rowsAsListOfValues.where((i) {
      if(i.length>2)
     return  i[2]== stateName;
    return false;
    }).toList();

    filteredByState.forEach((element) {
      element.add("0");
    });

    return filteredByState;
  }
  
}
