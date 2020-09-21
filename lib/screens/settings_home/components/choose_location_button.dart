import 'package:cost_of_care/bloc/home_settings_bloc/home_settings_bloc.dart';
import 'package:cost_of_care/bloc/home_settings_bloc/home_settings_event.dart';
import 'package:cost_of_care/bloc/home_settings_bloc/home_settings_state.dart';
import 'package:cost_of_care/models/home_settings_model.dart';
import 'package:cost_of_care/models/user_location_data.dart';
import 'package:cost_of_care/repository/location_access_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationButton extends StatefulWidget {
  final HomeSettingsLoadedState state;

  LocationButton(this.state);

  @override
  _LocationButtonState createState() => _LocationButtonState();
}

class _LocationButtonState extends State<LocationButton> {
  final Color borderChooseLocation = Colors.orange;

  final Color mainChooseLocation = Colors.white;
  String changeLocationText = 'Select a US state';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: borderChooseLocation),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            color: mainChooseLocation,
            onPressed: () async {
              LocationAccessRepositoryImpl locationAccess =
                  new LocationAccessRepositoryImpl();
              List<UserLocationData> list = locationAccess.stateCoordinatesList;
              print(list);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Choose A State',
                      ),
                      content: Container(
                        width: double.maxFinite,
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: <
                                Widget>[
                          Expanded(
                              child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                  title: Text(list[index].state),
                                  onTap: () async {
                                    double latitude = list[index].latitude;
                                    double longitude = list[index].longitude;
                                    String address = list[index].state;
                                    setState(() {
                                      changeLocationText =
                                          "Selected : $address";
                                      BlocProvider.of<HomeSettingsBloc>(context)
                                          .add(ChangeLocation(HomeSettingsModel(
                                              widget.state.homeSettingsModel
                                                  .radius,
                                              widget.state.homeSettingsModel
                                                  .order,
                                              widget.state.homeSettingsModel
                                                  .isSelected,
                                              latitude,
                                              longitude,
                                              address,
                                              address)));
                                    });
                                    Navigator.pop(context);
                                  });
                            },
                          ))
                        ]),
                      ),
                    );
                  });
            },
            padding: EdgeInsets.all(8),
            child: Text(
              changeLocationText,
              style: TextStyle(
                  color: borderChooseLocation,
                  fontFamily: 'Source',
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
