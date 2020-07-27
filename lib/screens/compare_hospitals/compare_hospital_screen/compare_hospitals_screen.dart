import 'package:curativecare/screens/compare_hospitals/compare_hospital_screen/components/body.dart';
import 'package:flutter/material.dart';

class CompareHospitalsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Compare Hospitals"
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
     body: Body(),
    );
  }
}