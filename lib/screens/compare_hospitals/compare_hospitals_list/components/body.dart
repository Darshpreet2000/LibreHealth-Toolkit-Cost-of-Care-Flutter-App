import 'package:curativecare/bloc/compare_screen_bloc/compare_screen_list/bloc.dart';
import 'package:curativecare/bloc/compare_screen_bloc/compare_screen_list/compare_screen_list_bloc.dart';
import 'package:curativecare/bloc/compare_screen_bloc/compare_screen_list/compare_screen_list_state.dart';
import 'package:curativecare/models/compare_hospital_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'list_tile.dart';

class Body extends StatefulWidget{
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {


  @override
  Widget build(BuildContext context) {
   return BlocListener<CompareScreenListBloc, CompareScreenListState>(
    listener: (BuildContext context, state) async {
      if(state is CompareScreenListErrorState){
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            state.message,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepOrangeAccent,
        ));
      }
    },
     child: BlocBuilder<CompareScreenListBloc, CompareScreenListState>(
      builder: (BuildContext context, CompareScreenListState state) {
            if(state is CompareScreenListLoadingState){
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            else if(state is CompareScreenListLoadedState){
              return showList(state.hospitalName);
            }
            else if(state is CompareScreenListErrorState){
              return Container(
                child: Center(child: Text(state.message,style: TextStyle(fontSize: 18),)),
              );
            }
       }
     ),
   );
  }


}

Widget showList(List<CompareHospitalModel> hospitalsName){
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