
import 'package:cost_of_care/screens/compare_hospitals/compare_hospital_screen/components/body.dart';
import 'package:flutter/material.dart';

class CompareHospitalsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compare Hospitals"),
        centerTitle: true,
        backgroundColor: Colors.orange,
        leading: BackButton(color: Colors.white),
      ),
      body: Body(),
    );
  }
}
