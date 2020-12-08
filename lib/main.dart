import 'package:cost_of_care/bloc/compare_hospital_bloc/compare_hospital_list/compare_hospital_list_bloc.dart';
import 'package:cost_of_care/bloc/home_settings_bloc/bloc.dart';
import 'package:cost_of_care/bloc/location_bloc/location_bloc.dart';
import 'package:cost_of_care/bloc/nearby_hospital_bloc/bloc.dart';
import 'package:cost_of_care/bloc/refresh_saved_cdm_bloc/refresh_saved_cdm_bloc.dart';
import 'package:cost_of_care/bloc/saved_screen_bloc/saved_screen_bloc.dart';
import 'package:cost_of_care/bloc/search_screen_bloc/bottom_sheet/bloc.dart';
import 'package:cost_of_care/bloc/search_screen_bloc/search_procedures/bloc.dart';
import 'package:cost_of_care/bloc/view_cdm_screen_bloc/bloc.dart';
import 'package:cost_of_care/bloc/view_cdm_statewise_screen_bloc/bloc.dart';
import 'package:cost_of_care/repository/compare_screen_repository_impl.dart';
import 'package:cost_of_care/repository/download_cdm_repository_impl.dart';
import 'package:cost_of_care/repository/home_settings_repository_impl.dart';
import 'package:cost_of_care/repository/location_repository_impl.dart';
import 'package:cost_of_care/repository/nearby_hospital_repository_impl.dart';
import 'package:cost_of_care/repository/saved_screen_repository_impl.dart';
import 'package:cost_of_care/repository/search_screen_repository_impl.dart';
import 'package:cost_of_care/repository/view_cdm_screen_repository_impl.dart';
import 'package:cost_of_care/repository/view_cdm_statewise_repository_impl.dart';
import 'package:cost_of_care/screens/about/about.dart';
import 'package:cost_of_care/screens/base/base_class.dart';
import 'package:cost_of_care/screens/compare_hospitals/compare_hospital_screen/compare_hospitals_screen.dart';
import 'package:cost_of_care/screens/compare_hospitals/compare_hospitals_list/compare_hospital.dart';
import 'package:cost_of_care/screens/intro/intro_screen.dart';
import 'package:cost_of_care/screens/search/search_screen.dart';
import 'package:cost_of_care/screens/settings_home/settings_home.dart';
import 'package:cost_of_care/screens/view_cdm_statewise/view_cdm_statewise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc/compare_hospital_bloc/compare_hospital_screen/compare_hospital_screen_bloc.dart';
import 'bloc/download_cdm_bloc/download_cdm_list/download_cdm_bloc.dart';
import 'bloc/download_cdm_bloc/download_cdm_progress/download_file_button_bloc.dart';
import 'bloc/report_a_bug_bloc/report_a_bug_bloc.dart';
import 'models/compare_hospital_model.dart';
import 'models/download_cdm_model.dart';
import 'models/hospitals.dart';

var box;
var listbox;

Future _openBox() async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(HospitalsAdapter());
  Hive.registerAdapter(DownloadCdmModelAdapter());
  Hive.registerAdapter(CompareHospitalModelAdapter());
  box = await Hive.openBox("myBox");
  listbox = await Hive.openBox<List>("listBox");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _openBox();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  //Base Class Contains Navigation Drawer & Bottom Navigation
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String initialAppRoute = '/BaseClass';

  @override
  void initState() {
    super.initState();
    if (!box.containsKey('introDisplayed')) {
      initialAppRoute = '/IntroScreen';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationBloc>(
          create: (BuildContext context) => LocationBloc(LocationRepoImpl()),
        ),
        BlocProvider<NearbyHospitalBloc>(
          create: (BuildContext context) =>
              NearbyHospitalBloc(NearbyHospitalsRepoImpl()),
        ),
        BlocProvider<HomeSettingsBloc>(
          create: (BuildContext context) =>
              HomeSettingsBloc(HomeSettingsRepoImpl()),
        ),
        BlocProvider<DownloadCdmBloc>(
          create: (BuildContext context) =>
              DownloadCdmBloc(DownloadCDMRepositoryImpl()),
        ),
        BlocProvider<ViewCdmScreenBloc>(
          create: (BuildContext context) =>
              ViewCdmScreenBloc(ViewCDMScreenRepositoryImpl()),
        ),
        BlocProvider<SavedScreenBloc>(
          create: (BuildContext context) =>
              SavedScreenBloc(SavedScreenRepoImpl()),
        ),
        BlocProvider<SearchScreenBloc>(
          create: (BuildContext context) =>
              SearchScreenBloc(SearchScreenRepositoryImpl()),
        ),
        BlocProvider<BottomSheetBloc>(
          create: (BuildContext context) =>
              BottomSheetBloc(SearchScreenRepositoryImpl()),
        ),
        BlocProvider<DownloadFileButtonBloc>(
          lazy: false,
          create: (BuildContext context) =>
              DownloadFileButtonBloc(DownloadCDMRepositoryImpl()),
        ),
        BlocProvider<ViewCdmStatewiseBloc>(
          create: (BuildContext context) =>
              ViewCdmStatewiseBloc(ViewCDMStatewiseRepositoryImpl()),
        ),

        BlocProvider<RefreshSavedCdmBloc>(
          create: (BuildContext context) => RefreshSavedCdmBloc(),
        ),
        BlocProvider<ReportABugBloc>(
          create: (BuildContext context) => ReportABugBloc(),
        ),

        BlocProvider<CompareHospitalScreenBloc>(
          create: (BuildContext context) => CompareHospitalScreenBloc(CompareScreenRepositoryImpl()),
        ),
        BlocProvider<CompareHospitalListBloc>(
          create: (BuildContext context) => CompareHospitalListBloc(CompareScreenRepositoryImpl()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Source',
          primaryColor: Colors.orange,
          accentColor: Colors.orangeAccent,
          primaryTextTheme:
              TextTheme(headline6: TextStyle(color: Colors.white)),
          textTheme: TextTheme(
            caption: TextStyle(fontSize: 16.0),
            bodyText1: TextStyle(fontSize: 16.0),
          ),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/IntroScreen': (context) => IntroScreen(),
          '/BaseClass': (context) => BaseClass(),
          '/SearchProcedure': (context) => SearchProcedure(),
          '/SettingsHome': (context) => SettingsHome(),
          '/ViewCDMStatewise': (context) => ViewCDMStatewise(),
          '/CompareHospitals': (context) => CompareHospitals(),
          '/About': (context) => About(),
          '/CompareHospitalsScreen': (context) => CompareHospitalsScreen(),
        },
        initialRoute: initialAppRoute,
      ),
    );
  }
}
