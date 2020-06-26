import 'package:curativecare/screens/home/components/nearby_hospital_list.dart';
import 'package:curativecare/widgets/user_location.dart';
import 'package:flutter/material.dart';

//Showing User location
//Showing List Of Hospitals with Shimmmer Effect

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  static const Color appBackgroundColor = Color(0xFFFFF7EC);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[100],
        child: Column(
          children: <Widget>[
            UserLocation(appBackgroundColor),
            Expanded(child: NearbyHospitalList())
            //List of Nearby
          ],
        ));
  }
}
