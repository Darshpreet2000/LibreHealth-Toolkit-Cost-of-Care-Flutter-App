import 'package:curativecare/models/compare_hospital_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    trailing: AddToCompareButton(hospitalName,index),
  );
}

class  AddToCompareButton extends StatefulWidget {
  CompareHospitalModel hospitalName;
  int index;

  AddToCompareButton(this.hospitalName, this.index);

  @override
  _AddToCompareButtonState createState() => _AddToCompareButtonState();
}

class _AddToCompareButtonState extends State<AddToCompareButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
    color: widget.hospitalName.isAddedToCompare?Colors.green:Colors.indigo,
    child: Text(
      widget.hospitalName.isAddedToCompare?"Comparing":"Compare",
      style: TextStyle(
          color: Colors.white
      ),
    ),
    onPressed:  ()  {
    setState(() {
      widget.hospitalName.isAddedToCompare=!widget.hospitalName.isAddedToCompare;
    });
    },
  );
  }
}
