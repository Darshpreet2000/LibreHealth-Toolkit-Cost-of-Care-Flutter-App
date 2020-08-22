import 'package:curativecare/bloc/compare_screen_bloc/compare_screen_list/bloc.dart';
import 'package:curativecare/bloc/home_settings_bloc/bloc.dart';
import 'package:curativecare/bloc/location_bloc/location_bloc.dart';
import 'package:curativecare/bloc/nearby_hospital_bloc/bloc.dart';
import 'package:curativecare/bloc/saved_screen_bloc/saved_screen_bloc.dart';
import 'package:curativecare/bloc/search_screen_bloc/bottom_sheet/bloc.dart';
import 'package:curativecare/bloc/search_screen_bloc/search_procedures/bloc.dart';
import 'package:curativecare/bloc/view_cdm_screen_bloc/bloc.dart';
import 'package:curativecare/bloc/view_cdm_statewise_screen_bloc/bloc.dart';
import 'package:curativecare/repository/compare_screen_repository_impl.dart';
import 'package:curativecare/repository/download_cdm_repository_impl.dart';
import 'package:curativecare/repository/home_settings_repository_impl.dart';
import 'package:curativecare/repository/location_repository_impl.dart';
import 'package:curativecare/repository/nearby_hospital_repository_impl.dart';
import 'package:curativecare/repository/saved_screen_repository_impl.dart';
import 'package:curativecare/repository/search_screen_repository_impl.dart';
import 'package:curativecare/repository/view_cdm_screen_repository_impl.dart';
import 'package:curativecare/repository/view_cdm_statewise_repository_impl.dart';
import 'package:curativecare/screens/about/about.dart';
import 'package:curativecare/screens/base/base_class.dart';
import 'package:curativecare/screens/compare_hospitals/compare_hospitals_list/compare_hospital.dart';
import 'package:curativecare/screens/intro/intro_screen.dart';
import 'package:curativecare/screens/report_an_issue/report_an_issue.dart';
import 'package:curativecare/screens/search/search_screen.dart';
import 'package:curativecare/screens/settings_home/settings_home.dart';
import 'package:curativecare/screens/view_cdm_statewise/view_cdm_statewise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'bloc/compare_screen_bloc/compare_screen/compare_screen_bloc.dart';
import 'bloc/download_cdm_bloc/download_cdm_list/download_cdm_bloc.dart';
import 'bloc/download_cdm_bloc/download_cdm_progress/download_file_button_bloc.dart';
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
          create: (BuildContext context) =>
              DownloadFileButtonBloc(DownloadCDMRepositoryImpl()),
        ),
        BlocProvider<ViewCdmStatewiseBloc>(
          create: (BuildContext context) =>
              ViewCdmStatewiseBloc(ViewCDMStatewiseRepositoryImpl()),
        ),
        BlocProvider<CompareScreenListBloc>(
          create: (BuildContext context) =>
              CompareScreenListBloc(CompareScreenRepositoryImpl()),
        ),
        BlocProvider<CompareScreenBloc>(
          create: (BuildContext context) =>
              CompareScreenBloc(CompareScreenRepositoryImpl()),
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
          '/ReportIssue': (context) => ReportIssue(),
        },
        initialRoute: initialAppRoute,
      ),
    );
  }
}
