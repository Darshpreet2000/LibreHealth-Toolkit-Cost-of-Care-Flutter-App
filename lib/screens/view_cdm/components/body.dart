import 'package:curativecare/screens/view_cdm/components/cdm.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  final String name;

  Body(this.name);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return CDM(widget.name);
  }
}
