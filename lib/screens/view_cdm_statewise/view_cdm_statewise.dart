import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_list/download_cdm_bloc.dart';
import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_list/download_cdm_event.dart';
import 'package:curativecare/bloc/view_cdm_statewise_screen_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../main.dart';
import 'components/body.dart';

class ViewCDMStatewise extends StatefulWidget {
  @override
  _ViewCDMStatewiseState createState() => _ViewCDMStatewiseState();
}

class _ViewCDMStatewiseState extends State<ViewCDMStatewise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View CDM Statewise'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Body(),

    );
  }
}
