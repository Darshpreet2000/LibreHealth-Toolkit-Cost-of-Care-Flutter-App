import 'package:curativecare/bloc/location_bloc/location_bloc.dart';
import 'package:curativecare/bloc/location_bloc/user_location_state.dart';
import 'package:curativecare/screens/home/components/nearby_hospital_list.dart';
import 'package:curativecare/widgets/user_location.dart';
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
        }
      },
      child: Column(
        children: <Widget>[
          widget.userLocationWidget,
          Expanded(child: NearbyHospitalList())
          //List of Nearby
        ],
      ),
    );
  }
}
