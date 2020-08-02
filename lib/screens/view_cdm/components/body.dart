import 'package:curativecare/bloc/search_screen_bloc/search_procedures/search_screen_bloc.dart';
import 'package:curativecare/bloc/view_cdm_screen_bloc/view_cdm_screen_bloc.dart';
import 'package:curativecare/screens/view_cdm/components/cdm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatefulWidget {
  String name;

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
