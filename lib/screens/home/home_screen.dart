import 'package:cost_of_care/bloc/location_bloc/location_bloc.dart';
import 'package:cost_of_care/bloc/location_bloc/user_location_events.dart';
import 'package:cost_of_care/widgets/user_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/app_bar_home.dart';
import 'components/body.dart';

class Home extends StatefulWidget {
  Home(this.drawerKey);

  final GlobalKey<ScaffoldState> drawerKey;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const Color appBackgroundColor = Color(0xFFFFF7EC);
  final userLocationWidget = UserLocation(appBackgroundColor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: <Widget>[
          AppBarHome(widget.drawerKey, userLocationWidget),
          SizedBox(
            height: 5,
          ),
          Expanded(child: Body(userLocationWidget)),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LocationBloc>(context).add(FetchLocation());
  }
}
