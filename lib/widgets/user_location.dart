import 'package:curativecare/bloc/location_bloc.dart';
import 'package:curativecare/models/location.dart';
import 'package:curativecare/models/nearby_hospital.dart';
import 'package:curativecare/repository/location_repository.dart';
import 'package:curativecare/widgets/dash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class UserLocation extends StatefulWidget {
  Color appBackgroundColor;
  UserLocation(this.appBackgroundColor);

  @override
  _UserLocationState createState() => _UserLocationState();
}
class _UserLocationState extends State<UserLocation> {
  final location=Location_Repository();
  SharedPreferences prefs;
  bool isLoading = true;
  String address;
  final snackBar = SnackBar(
    content: Text(
      'Refreshing',
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.deepOrangeAccent,
  );

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
      setState(()  {
        address = prefs.getString('address');
        isLoading = false;
      });
    }
//If data is not present then ask for location & then store it in shared preference
    if (isLoading) {
      location.getLocationPermission().then((value) => setState(() async {
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
    location.getLocationPermission().then((value) => setState(() async {
          address = value;
          isLoading = false;
        }));
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) { LocationBloc(Location_Repository()); },
      child: Container(
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
      ),

    );
  }
}
