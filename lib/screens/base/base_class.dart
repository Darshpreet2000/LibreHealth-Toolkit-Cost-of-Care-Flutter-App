import 'package:cost_of_care/bloc/report_a_bug_bloc/report_a_bug_bloc.dart';
import 'package:cost_of_care/screens/download_cdm/download_cdm_screen.dart';
import 'package:cost_of_care/screens/home/home_screen.dart';
import 'package:cost_of_care/screens/report_an_issue/report_an_issue.dart';
import 'package:cost_of_care/screens/saved/saved_screen.dart';
import 'package:cost_of_care/screens/share_app/share_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info/package_info.dart';

class BaseClass extends StatefulWidget {
  @override
  _BaseClassState createState() => _BaseClassState();
}

class _BaseClassState extends State<BaseClass> {
  int selectedIndex = 0;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      body: IndexedStack(
        index: selectedIndex,
        children: <Widget>[
          Home(_drawerKey),
          DownloadCDMScreen(),
          Saved(),
        ],
      ),
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.cloud_download,
                size: 25,
              ),
              label: 'Download CDM'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), label: 'Saved'),
        ],
        currentIndex: selectedIndex,
        fixedColor: Colors.orange,
        onTap: onItemTapped,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.description,
              text: 'View CDM Statewise',
              onTap: () => {
                    Navigator.pop(context),
                    Navigator.pushNamed(context, '/ViewCDMStatewise')
                  }),
          Divider(),
          _createDrawerItem(
              icon: Icons.local_hospital,
              text: 'Compare Hospitals',
              onTap: () => {
                    Navigator.pop(context),
                    Navigator.pushNamed(context, '/CompareHospitals')
                  }),
          Divider(),
          _createDrawerItem(
              icon: Icons.share,
              text: 'Share App',
              onTap: () => {Navigator.pop(context), shareApp()}),
          Divider(),
          _createDrawerItem(
              icon: Icons.book,
              text: 'About',
              onTap: () => {
                    Navigator.pop(context),
                    Navigator.pushNamed(context, '/About')
                  }),
          Divider(),
          _createDrawerItem(
              icon: Icons.bug_report,
              text: 'Report A Bug',
              onTap: () async {
                try {
                  await reportABug();
                } catch (e) {
                  BlocProvider.of<ReportABugBloc>(context)
                      .add(ShowErrorSnackBarEvent(e.message));
                }

                Navigator.pop(context);
              }),
          ListTile(
            title: FutureBuilder(
              future: getAppInfo(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data);
                }
                return Text("1.0.0");
              },
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Future getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    return version;
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.black,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _createHeader() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.orange,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/libre_white.png',
                    height: 200,
                    width: 200,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              'Providing better cost estimates',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontStyle: FontStyle.italic),
            ),
          ),
          SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}
