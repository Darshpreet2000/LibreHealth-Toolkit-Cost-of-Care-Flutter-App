import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Text('About App'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/librehealth.png',
                      height: 100,
                      width: 200,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "The Goal of this Cost Of Care Project is to provide patient friendly costs of care, to help patients get better cost estimates for medical procedures of US Hospitals." +
                      " User can view the chargemaster, search for a particular procedure in multiple hospitals chargemasters & can sort data by Category or sort by price in ascending or descending order." +
                      " App downloads hospitals chargemaster from GitLab Repository and save it to local storage of phone in SQL database." +
                      " This App can work offline and updates data once in a month." +
                      "\n This is Free & Open Source project," +
                      " you can visit to LibreHealth to know more about it & can contribute if you have an interesting idea",
                  style: TextStyle(
                    fontSize: 17,
                    height: 1.8,
                    fontFamily: 'Source',
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    color: Colors.white,
                    onPressed: () {
                      _launchURL();
                    },
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Visit Project',
                      style: TextStyle(
                          color: Colors.orange,
                          fontFamily: 'Source',
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchURL() async {
    const url =
        'https://gitlab.com/librehealth/toolkit/cost-of-care/lh-toolkit-cost-of-care-app';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
