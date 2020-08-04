import 'package:curativecare/bloc/compare_screen_bloc/compare_screen_list/bloc.dart';
import 'package:curativecare/models/compare_hospital_model.dart';
import 'package:curativecare/screens/compare_hospitals/compare_hospital_screen/compare_hospitals_screen.dart';
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
           CompareScreenListLoadedState state= context.bloc<CompareScreenListBloc>().state as CompareScreenListLoadedState;
            List<CompareHospitalModel> hospitals=state.hospitalName;
            List<CompareHospitalModel> hospitalNamesForCompare=hospitals.where((element) => element.isAddedToCompare==true).toList();
             if(hospitalNamesForCompare.length>=2) {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) =>
                     CompareHospitalsScreen(hospitalNamesForCompare)),
               );
             }
             else{
               context.bloc<CompareScreenListBloc>().add(CompareScreenListCompareButtonError("Please add at least two Hospitals to compare"));

             }
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

  @override
  void initState() {
   super.initState();
    context.bloc<CompareScreenListBloc>().add(CompareScreenListFetchHospitalName());
  }


}
