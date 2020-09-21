import 'package:cost_of_care/screens/search/components/bottom_sheet_switch.dart';
import 'package:flutter/material.dart';

class FloatingAction extends StatefulWidget {
  @override
  _FloatingActionState createState() => _FloatingActionState();
}

class _FloatingActionState extends State<FloatingAction> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet<void>(
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          context: context,
          builder: (BuildContext context) {
            return BottomSheetSwitch();
          },
        );
      },
      backgroundColor: Colors.orange,
      child: Icon(
        Icons.filter_list,
        color: Colors.white,
      ),
    );
  }
}
