import 'package:curativecare/models/compare_hospital_model.dart';
import 'package:flutter/material.dart';

import 'list_tile.dart';

class Body extends StatelessWidget{
  List<CompareHospitalModel> hospitalName=new List();

  @override
  Widget build(BuildContext context) {
   return ShowList(hospitalName);
  }
}

Widget ShowList(List<CompareHospitalModel> hospitalsName){
  hospitalsName.add(new CompareHospitalModel("NY EYE AND EAR INFIRMARY OF MOUNT SINAI", false));
  hospitalsName.add(new CompareHospitalModel("MOUNT SINAI BETH ISRAEL", false));
  hospitalsName.add(new CompareHospitalModel("JERSEY CITY MEDICAL CENTER", false));
  hospitalsName.add(new CompareHospitalModel("UCLA MEDICAL CENTER", false));
  hospitalsName.add(new CompareHospitalModel("ALASKA NATIVE MEDICAL CENTER", false));
  hospitalsName.add(new CompareHospitalModel("ALASKA PSYCHIATRIC INSTITUTE", false));
  return Scrollbar(
    child: ListView.builder(
      itemCount: hospitalsName.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 4.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.grey[50]),
            child: makeListTile(context, hospitalsName[index], index),
          ),
        );
      },
    ),
  );
}