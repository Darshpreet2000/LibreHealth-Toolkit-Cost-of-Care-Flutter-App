import 'package:cost_of_care/bloc/location_bloc/location_bloc.dart';
import 'package:cost_of_care/bloc/location_bloc/user_location_state.dart';
import 'package:cost_of_care/bloc/report_a_bug_bloc/report_a_bug_bloc.dart';
import 'package:cost_of_care/screens/home/components/nearby_hospital_list.dart';
import 'package:cost_of_care/widgets/user_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatefulWidget {
  final userLocationWidget;

  Body(this.userLocationWidget);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationBloc, LocationState>(
        listener: (BuildContext context, state) {
          if (state is LocationError) {
            if (state.message == "Permission Denied, Enable from Settings") {
              showCustomPermissionDialog(context);
            }
            if (state.message == "You need to Enable GPS/Location Service") {
              showCustomLocationServiceDialog(context);
            }
          }
        },
        child: BlocListener<ReportABugBloc, ReportABugState>(
          listener: (BuildContext context, state) {
            if (state is ReportABugShowSnackBarState) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.message,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ));
            }
          },
          child: Column(
            children: <Widget>[
              widget.userLocationWidget,
              Expanded(child: NearbyHospitalList())
              //List of Nearby
            ],
          ),
        ));
  }
}
