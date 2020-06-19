import 'package:curativecare/bloc/location_bloc/location_bloc.dart';
import 'package:curativecare/bloc/nearby_hospital_bloc/bloc.dart';
import 'package:curativecare/repository/location_repository.dart';
import 'package:curativecare/repository/nearby_hospitals_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curativecare/screens/about/about.dart';
import 'package:curativecare/screens/compare_hospitals/compare_hospital.dart';
import 'package:curativecare/screens/report_an_issue/report_an_issue.dart';
import 'package:curativecare/screens/search/search_screen.dart';
import 'package:curativecare/screens/settings_home/settings_home.dart';
import 'package:curativecare/screens/share_app/share_app.dart';
import 'package:curativecare/screens/view_cdm_statewise/view_cdm_statewise.dart';
import 'package:flutter/material.dart';

import 'base/base_class.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //Base Class Contains Navigation Drawer & Bottom Navigation
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationBloc>(
          create: (BuildContext context) => LocationBloc(Location_Repository()),
        ),
        BlocProvider<NearbyHospitalBloc>(
          create: (BuildContext context) =>
              NearbyHospitalBloc(NearbyHospitals_Repository()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Source',
          textTheme: TextTheme(
            caption: TextStyle(fontSize: 16.0),
            bodyText1: TextStyle(fontSize: 16.0),
          ),
        ),
        routes: {
          '/': (context) => BaseClass(),
          '/SearchProcedure': (context) => SearchProcedure(),
          '/SettingsHome': (context) => SettingsHome(),
          '/ViewCDMStatewise': (context) => ViewCDMStatewise(),
          '/CompareHospitals': (context) => CompareHospitals(),
          '/Share': (context) => ShareApp(),
          '/About': (context) => About(),
          '/ReportIssue': (context) => ReportIssue(),
        },
        initialRoute: '/',
      ),
    );
  }
}
