import 'dart:io';
import 'package:curativecare/widgets/dash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomSheetSwitch extends StatefulWidget {
  @override
  _BottomSheetSwitch createState() => _BottomSheetSwitch();
}

class _BottomSheetSwitch extends State<BottomSheetSwitch> {
  final constraints = BoxConstraints(
    maxWidth: 800.0, // maxwidth calculated
    minHeight: 0.0,
    minWidth: 0.0,
  );

// Declare this variable
  int selectedRadioTile;
  int priceRadioTile;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    opensavedValues();
  }

  Future<void> opensavedValues() async {
    prefs = await SharedPreferences.getInstance();
    selectedRadioTile = (prefs.getInt('category') ?? 0);
    priceRadioTile = (prefs.getInt('price') ?? 0);
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  SelectedRadioTile(int val) {
    setState(() {
      priceRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          height: 500,
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              )),
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 12, bottom: 8),
                    child: Text(
                      'Sort by',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Source',
                          fontWeight: FontWeight.w600,
                          fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.cancel,
                        size: 30,
                      ),
                      onPressed: () => {Navigator.pop(context)},
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Dash(
                  length: MediaQuery.of(context).size.width - 32,
                  dashColor: Colors.grey,
                  dashThickness: 2,
                  dashLength: 2,
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, bottom: 8),
                    child: Text(
                      'Category',
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Source',
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              RadioListTile(
                value: 1,
                groupValue: selectedRadioTile,
                title: Text("Standard"),
                onChanged: (val) {
                  print("Radio Tile pressed $val");
                  setSelectedRadioTile(val);
                },
                activeColor: Colors.indigo,
                selected: false,
              ),
              RadioListTile(
                value: 2,
                groupValue: selectedRadioTile,
                title: Text("DRG"),
                onChanged: (val) {
                  print("Radio Tile pressed $val");
                  setSelectedRadioTile(val);
                },
                activeColor: Colors.indigo,
                selected: false,
              ),
              RadioListTile(
                value: 3,
                groupValue: selectedRadioTile,
                title: Text("Pharmacy"),
                onChanged: (val) {
                  print("Radio Tile pressed $val");
                  setSelectedRadioTile(val);
                },
                activeColor: Colors.indigo,
                selected: false,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Dash(
                  length: MediaQuery.of(context).size.width - 32,
                  dashColor: Colors.grey,
                  dashThickness: 2,
                  dashLength: 2,
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, bottom: 8),
                    child: Text(
                      'Price',
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Source',
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              RadioListTile(
                value: 1,
                groupValue: priceRadioTile,
                title: Text("Ascending"),
                onChanged: (val) {
                  print("Radio Tile pressed $val");
                  SelectedRadioTile(val);
                },
                activeColor: Colors.indigo,
                selected: false,
              ),
              RadioListTile(
                value: 2,
                groupValue: priceRadioTile,
                title: Text("Descending"),
                onChanged: (val) {
                  print("Radio Tile pressed $val");
                  SelectedRadioTile(val);
                },
                activeColor: Colors.indigo,
                selected: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    color: Colors.indigo,
                    onPressed: () {
                      save_Values();
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: Text(
                      'Apply',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Source',
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }

  Future<void> save_Values() async {
    prefs.setInt('category', selectedRadioTile);
    prefs.setInt('price', priceRadioTile);
  }
}
