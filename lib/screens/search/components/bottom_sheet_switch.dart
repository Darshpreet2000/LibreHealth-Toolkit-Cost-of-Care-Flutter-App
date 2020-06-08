import 'package:curativecare/widgets/dash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

  @override
  void initState() {
    super.initState();
    priceRadioTile = 0;
    selectedRadioTile = 0;
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
              borderRadius: new BorderRadius.all(
                Radius.circular(25.0),
              )),
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 12, bottom: 8),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                Material(

                  color: Colors.white,
                  child:
                  InkWell(

                    onTap: ()=>{},
                    child: Text('Cancel',

                      style: TextStyle(
                          color: Colors.indigo,
                          fontFamily: 'Source',
                          fontWeight: FontWeight.w600,
                          fontSize: 22),
                    ),
                  ),
                ),
                    Material(
                      color: Colors.white,
                      child:
                      InkWell(

                        onTap: ()=>{},
                        child: Text('Done',

                          style: TextStyle(
                              color: Colors.indigo,
                              fontFamily: 'Source',
                              fontWeight: FontWeight.w600,
                              fontSize: 22),
                        ),
                      ),
                    ),

      ],
                ),
              )
            ],
          )),
    );
  }
}
