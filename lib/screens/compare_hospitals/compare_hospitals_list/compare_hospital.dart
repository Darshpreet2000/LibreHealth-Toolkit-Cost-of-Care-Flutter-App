
import 'package:cost_of_care/bloc/compare_hospital_bloc/compare_hospital_list/compare_hospital_list_bloc.dart';
import 'package:cost_of_care/bloc/compare_hospital_bloc/compare_hospital_screen/compare_hospital_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body.dart';

class CompareHospitals extends StatefulWidget {
  @override
  _CompareHospitalsState createState() => _CompareHospitalsState();
}

class _CompareHospitalsState extends State<CompareHospitals> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Available Hospitals To Compare'),
          centerTitle: true,
          backgroundColor: Colors.orange,
          leading: BackButton(color: Colors.white),
        ),
        body: Body(BlocProvider.of<CompareHospitalListBloc>(context)),

        floatingActionButton: Container(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton.extended(
              backgroundColor: Colors.orange,
              onPressed: () {
                BlocProvider.of<CompareHospitalListBloc>(context).add(FloatingCompareHospitalButtonPress(BlocProvider.of<CompareHospitalScreenBloc>(context)));
                 if(BlocProvider.of<CompareHospitalListBloc>(context).hospitalsAddedToCompare==2)
                     Navigator.pushNamed(context, '/CompareHospitalsScreen');
              },
              icon: Icon(
                Icons.compare,
                color: Colors.white,
              ),
              label: Text(
                "Compare Hospitals",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Source',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }

  @override
  void initState() {
    super.initState();
     BlocProvider.of<CompareHospitalListBloc>(context).add(GetCompareData());
  }
}
