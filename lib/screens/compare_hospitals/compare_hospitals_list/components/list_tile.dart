
import 'package:cost_of_care/bloc/compare_hospital_bloc/compare_hospital_list/compare_hospital_list_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ListTile makeListTile(
    BuildContext context, String hospitalName,int isHospitalAddedToCompare ,int index,CompareHospitalListBloc compareHospitalListBloc) {
  return ListTile(
    title: Text(
      hospitalName,
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
      color: isHospitalAddedToCompare==1 ? Colors.green : Colors.orange,
      child: Text(
        isHospitalAddedToCompare==1 ? "Comparing" : "Compare",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        compareHospitalListBloc.add(UpdateHospitalToCompare(index));
        },
    ),
  );
}
