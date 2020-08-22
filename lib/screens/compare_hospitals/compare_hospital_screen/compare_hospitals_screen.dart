import 'package:curativecare/models/compare_hospital_model.dart';
import 'package:curativecare/screens/compare_hospitals/compare_hospital_screen/components/body.dart';
import 'package:flutter/material.dart';

class CompareHospitalsScreen extends StatelessWidget {
  final List<CompareHospitalModel> hospitalNamesForCompare;

  CompareHospitalsScreen(this.hospitalNamesForCompare);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compare Hospitals"),
        centerTitle: true,
        backgroundColor: Colors.orange,
        leading: BackButton(color: Colors.white),
      ),
      body: Body(hospitalNamesForCompare),
    );
  }
}
