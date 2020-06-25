import 'package:curativecare/screens/download_cdm/download_cdm_screen.dart';
import 'package:curativecare/screens/home/home_screen.dart';
import 'package:curativecare/screens/saved/saved_screen.dart';
import 'package:flutter/material.dart';

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
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.cloud_download,
                size: 25,
              ),
              title: Text('Download CDM')),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), title: Text('Saved')),
        ],
        currentIndex: selectedIndex,
        fixedColor: Colors.indigo,
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
              icon: Icons.album,
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
              onTap: () => {
                    Navigator.pop(context),
                    Navigator.pushNamed(context, '/Share')
                  }),
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
              text: 'Report a bug',
              onTap: () => {
                    Navigator.pop(context),
                    Navigator.pushNamed(context, '/ReportIssue')
                  }),
          ListTile(
            title: Text('0.0.1'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/logowhite.png',
            height: 50,
            width: 50,
          ),
          Text(
            'LibreHealth',
            style: TextStyle(color: Colors.white, fontSize: 25),
          )
        ],
      ),
    );
  }
}
