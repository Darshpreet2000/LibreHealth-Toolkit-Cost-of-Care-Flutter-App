import 'package:curativecare/bloc/location_bloc/location_bloc.dart';
import 'package:curativecare/bloc/location_bloc/user_location_events.dart';
import 'package:curativecare/bloc/location_bloc/user_location_state.dart';
import 'package:curativecare/widgets/dash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class UserLocation extends StatefulWidget {
  Color appBackgroundColor;

  UserLocation(this.appBackgroundColor);

  @override
  _UserLocationState createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {
  @override
  void initState() {
    context.bloc<LocationBloc>().add(FetchLocation());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: EdgeInsets.only(top: 8.0, left: 10, right: 10),
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
                width: 8.0,
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
              Container(
                  width: MediaQuery.of(context).size.width - 20,
                  child: BlocListener<LocationBloc, LocationState>(
                    listener: (BuildContext context, state) {
                      if (state is LocationError) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Location Not Found',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.deepOrangeAccent,
                        ));
                      }
                    },
                    child: BlocBuilder<LocationBloc, LocationState>(
                      builder: (BuildContext context, state) {
                        if (state is LocationLoading) {
                          return buildLoading(context);
                        } else if (state is LocationLoaded) {
                          return buildData(context, state.address);
                        } else if (state is LocationError) {
                          return buildData(context, state.message);
                        }
                        return buildLoading(context);
                      },
                    ),
                  )),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(top: 4.0),
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

Widget buildLoading(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - 20,
    height: 30.0,
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    ),
  );
}

Widget buildData(BuildContext context, String address) {
//  final locationBloc=BlocProvider.of<LocationBloc>(context);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Flexible(
        child: Text(
          address,
          style: TextStyle(
              color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: false,
        ),
      ),
      IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () {
          context.bloc<LocationBloc>().add(RefreshLocation());
        },
      )
    ],
  );
}
