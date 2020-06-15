import 'package:curativecare/widgets/dash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:shimmer/shimmer.dart';

class UserLocation extends StatefulWidget {
   Color appBackgroundColor;

   UserLocation(this.appBackgroundColor);

  @override
  _UserLocationState createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {

  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData position;

  Future<String> getcurrentlocation() async {

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return 'Location Not Found';
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return 'Location Not Found';
      }
    }
   return getcoordiantes();
  }
  Future<String> getcoordiantes() async {
    position = await location.getLocation();
   try {
     List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
     String address=placemark[0].name+", "+placemark[0].subLocality+", "+placemark[0].locality+", "+placemark[0].country;
     return address;
   }  on PlatformException catch (e) {
       return 'Location Not Found';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
     color: Colors.grey[100],
      padding: EdgeInsets.only(top:10.0,left: 10,right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
           Row(
            children: <Widget>[
              Icon(Icons.location_on,color: Colors.grey,size: 24,),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'YOUR LOCATION',
                style: TextStyle(
                    color: Colors.grey,fontSize: 16.0,fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child:

               Container(
                   width: MediaQuery.of(context).size.width-20,

               child:  FutureBuilder(
                   future: getcurrentlocation(),
                   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                     if(snapshot.hasData){
                       return Text(
                           snapshot.data,
                           style: TextStyle(
                               color: Colors.black,fontSize: 16.0, fontWeight: FontWeight.bold
                           ),
                           overflow: TextOverflow.ellipsis,
                           maxLines: 1,
                           softWrap: false,
                         );
                     }

                     else{
                       return SizedBox(
                         width: MediaQuery.of(context).size.width-20,
                         height: 30.0,
                         child: Shimmer.fromColors(
                           baseColor: Colors.grey[300],
                           highlightColor: Colors.white,
                           child:    Container(

                             decoration: BoxDecoration(
                               color: Colors.grey[300],
                               borderRadius: BorderRadius.all(Radius.circular(20))
                           ),

                           ),
                         ),


                       );
                     }
                   },

                 ),

              )
    ),
            ],
          ),
        Padding(
         padding: const EdgeInsets.only(top:8.0),
         child:
          Dash(length: MediaQuery.of(context).size.width-20, dashColor: Colors.blue,dashThickness: 4,dashLength: 15,)
          )
         ],
      ),
    );
  }
}
