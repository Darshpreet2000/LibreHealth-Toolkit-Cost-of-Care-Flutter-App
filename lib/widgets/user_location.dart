import 'package:curativecare/widgets/dash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class UserLocation extends StatefulWidget {
  Color appBackgroundColor;

  UserLocation(this.appBackgroundColor);

  @override
  _UserLocationState createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {
  SharedPreferences prefs;
  final snackBar = SnackBar(
    content: Text(
      'Refreshing',
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.deepOrangeAccent,
  );
  bool isLoading = true;
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData position;
  String address;
  Future<String> future;

  @override
  Future<void> initState() {
    check_saved();
  }

  Future check_saved() async {
    //Check if data already present in shared preference
    //If yes the use it & don't use location
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('latitude') &&
        prefs.containsKey('longitude') &&
        prefs.containsKey('address')) {
      setState(() {
        address = prefs.getString('address');
        isLoading = false;
      });
    }
//If data is not present then ask for location & then store it in shared preference
    if (isLoading) {
      getcurrentlocation().then((value) => setState(() {
            address = value;
            isLoading = false;
          }));
    }
  }

  void refresh() {
    //Use it for refreshing data
    Scaffold.of(context).showSnackBar(snackBar);
    setState(() {
      isLoading = true;
    });
    getcurrentlocation().then((value) => setState(() {
          address = value;
          isLoading = false;
        }));
  }

  Future<String> getcurrentlocation() async {
    //Ask for Location permissions & Location Services
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
    return getcoordinates();
  }

  Future<String> getcoordinates() async {
    prefs = await SharedPreferences.getInstance();
    position = await location.getLocation();
    //Save coordinate in shared preference
    //To use it in Overpass API
    prefs.setString('latitude', position.latitude.toString());
    prefs.setString('longitude', position.longitude.toString());
    try {
      List<Placemark> placemark = await Geolocator()
          .placemarkFromCoordinates(position.latitude, position.longitude);
      String address = placemark[0].name +
          ", " +
          placemark[0].subLocality +
          ", " +
          placemark[0].locality +
          ", " +
          placemark[0].country;
      //Save address
      prefs.setString('address', address);
      return address;
    } on PlatformException catch (e) {
      return 'Location Not Found';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: EdgeInsets.only(top: 10.0, left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.location_on,
                color: Colors.grey,
                size: 24,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'YOUR LOCATION',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width - 20,
                      child: isLoading == false
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  address,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                                IconButton(
                                  icon: Icon(Icons.refresh),
                                  onPressed: () {
                                    refresh();
                                  },
                                )
                              ],
                            )
                          : SizedBox(
                              width: MediaQuery.of(context).size.width - 20,
                              height: 30.0,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.white,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                              ),
                            ))),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Dash(
                length: MediaQuery.of(context).size.width - 20,
                dashColor: Colors.blue,
                dashThickness: 4,
                dashLength: 15,
              ))
        ],
      ),
    );
  }
}
