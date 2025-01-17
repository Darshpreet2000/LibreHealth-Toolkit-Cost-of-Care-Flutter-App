import 'package:cost_of_care/bloc/search_screen_bloc/bottom_sheet/bloc.dart';
import 'package:cost_of_care/widgets/dash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  int categoryRadioTile;
  int priceRadioTile;
  bool searchBy;
  String searchByStringValue;

  @override
  void initState() {
    super.initState();
    context.bloc<BottomSheetBloc>().add(BottomSheetFetchValues());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomSheetBloc, BottomSheetState>(
        builder: (BuildContext context, BottomSheetState state) {
      if (state is BottomSheetLoadValues || state is BottomSheetApplyValues) {
        categoryRadioTile = state.selectedRadioTile;
        priceRadioTile = state.priceRadioTile;
        searchBy = state.searchBy;
        if (searchBy)
          searchByStringValue = "Price";
        else
          searchByStringValue = "Procedure";

        return SingleChildScrollView(
          child: Container(
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
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 12, bottom: 8),
                        child: Text(
                          'Filter by',
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
                            color: Colors.orange,
                          ),
                          onPressed: () => {Navigator.pop(context)},
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 0, 0, 4),
                    child: Dash(
                      length: MediaQuery.of(context).size.width - 32,
                      dashColor: Colors.grey,
                      dashThickness: 2,
                      dashLength: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, bottom: 8),
                    child: Text(
                      'Search',
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Source',
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 8),
                        child: Text(
                          'Searching by $searchByStringValue',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Switch(
                        value: searchBy,
                        onChanged: (bool value) {
                          context.bloc<BottomSheetBloc>().add(
                              BottomSheetChangeValue(categoryRadioTile,
                                  priceRadioTile, !searchBy));
                        },
                        activeTrackColor: Colors.orangeAccent[100],
                        activeColor: Colors.orange,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 0, 0, 4),
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
                    groupValue: categoryRadioTile,
                    title: Text("Standard"),
                    onChanged: (val) {
                      print("Radio Tile pressed $val");

                      context.bloc<BottomSheetBloc>().add(
                          BottomSheetChangeValue(
                              val, priceRadioTile, searchBy));
                    },
                    activeColor: Colors.orange,
                    selected: false,
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: categoryRadioTile,
                    title: Text("DRG"),
                    onChanged: (val) {
                      context.bloc<BottomSheetBloc>().add(
                          BottomSheetChangeValue(
                              val, priceRadioTile, searchBy));
                    },
                    activeColor: Colors.orange,
                    selected: false,
                  ),
                  RadioListTile(
                    value: 3,
                    groupValue: categoryRadioTile,
                    title: Text("Pharmacy"),
                    onChanged: (val) {
                      print("Radio Tile pressed $val");

                      context.bloc<BottomSheetBloc>().add(
                          BottomSheetChangeValue(
                              val, priceRadioTile, searchBy));
                    },
                    activeColor: Colors.orange,
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
                      context.bloc<BottomSheetBloc>().add(
                          BottomSheetChangeValue(
                              categoryRadioTile, val, searchBy));
                    },
                    activeColor: Colors.orange,
                    selected: false,
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: priceRadioTile,
                    title: Text("Descending"),
                    onChanged: (val) {
                      context.bloc<BottomSheetBloc>().add(
                          BottomSheetChangeValue(
                              categoryRadioTile, val, searchBy));
                    },
                    activeColor: Colors.orange,
                    selected: false,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.orange),
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
                          color: Colors.white,
                          onPressed: () {
                            context // Setting Default Value when clear all is pressed
                                .bloc<BottomSheetBloc>()
                                .add(BottomSheetApply(0, 0, false));
                          },
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Clear All',
                            style: TextStyle(
                                color: Colors.orange,
                                fontFamily: 'Source',
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0))),
                          color: Colors.orange,
                          onPressed: () {
                            //Apply on pressed
                            context.bloc<BottomSheetBloc>().add(
                                BottomSheetApply(categoryRadioTile,
                                    priceRadioTile, searchBy));
                            Navigator.pop(context);
                          },
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Apply',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Source',
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  )
                ],
              )),
        );
      }

      return Container();
    });
  }
}
