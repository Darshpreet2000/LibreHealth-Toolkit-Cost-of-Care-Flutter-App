import 'package:flutter/material.dart';

import 'components/body.dart';

class ViewCDM extends StatefulWidget {
  String name;

  ViewCDM(this.name);

  @override
  _ViewCDMState createState() => _ViewCDMState();
}

class _ViewCDMState extends State<ViewCDM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text(
          widget.name,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Body(widget.name),
    );
  }
}
