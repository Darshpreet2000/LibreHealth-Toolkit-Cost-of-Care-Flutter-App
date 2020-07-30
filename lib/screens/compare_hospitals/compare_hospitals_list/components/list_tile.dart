import 'package:curativecare/bloc/compare_screen_bloc/compare_screen_list/bloc.dart';
import 'package:curativecare/models/compare_hospital_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

ListTile makeListTile(BuildContext context, CompareHospitalModel hospitalName,int index) {
  return ListTile(
    title: Text(
      hospitalName.hospitalName,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Source',
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    ),
    trailing: RaisedButton(
      color: hospitalName.isAddedToCompare?Colors.green:Colors.indigo,
      child: Text(
        hospitalName.isAddedToCompare?"Comparing":"Compare",
        style: TextStyle(
            color: Colors.white
        ),
      ),
      onPressed:  ()  {
        context.bloc<CompareScreenListBloc>().add(CompareScreenListCompareButtonEvent(!hospitalName.isAddedToCompare,index));
      },
    ),
  );
}

