import 'package:curativecare/screens/compare_hospitals/compare_hospital_screen/compare_hospitals_screen.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class CompareHospitals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Hospitals To Compare'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Body(),

      floatingActionButton: Container(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Align(

          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
           backgroundColor: Colors.indigo,
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompareHospitalsScreen()),
              );
            },
            icon: Icon(Icons.compare),
            label: Text("Compare Hospitals", style: TextStyle(
              color: Colors.white,
              fontFamily: 'Source',
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,


    );
  }
}
