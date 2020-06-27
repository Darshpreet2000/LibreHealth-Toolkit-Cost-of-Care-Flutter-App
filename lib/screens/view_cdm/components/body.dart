import 'package:curativecare/screens/view_cdm/components/cdm.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  String name;

  Body(this.name);

  @override
  Widget build(BuildContext context) {
    return CDM(name);
  }
}
