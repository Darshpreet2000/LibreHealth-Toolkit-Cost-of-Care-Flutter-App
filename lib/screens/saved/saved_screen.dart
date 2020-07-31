import 'package:flutter/material.dart';

import 'components/body.dart';

class Saved extends StatefulWidget {
  FloatingActionButton bottomSheet;

  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text(
            'Saved ChargeMasters',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Body());
  }
}
