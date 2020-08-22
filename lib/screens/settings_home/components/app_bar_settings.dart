import 'package:curativecare/bloc/home_settings_bloc/bloc.dart';
import 'package:curativecare/bloc/location_bloc/location_bloc.dart';
import 'package:curativecare/bloc/location_bloc/user_location_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

AppBar settingsAppBar(BuildContext context, HomeSettingsState state) {
  return AppBar(
      title: Text(
        'Settings',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      leading: BackButton(color: Colors.white),
      backgroundColor: Colors.orange,
      actions: <Widget>[
        Builder(
          builder: (BuildContext context) {
            return FlatButton(
              textColor: Colors.white,
              onPressed: () {
                if (state is HomeSettingsLoadedState) if (state
                            .homeSettingsModel.latitude !=
                        null &&
                    state.homeSettingsModel.longitude != null) {
                  context
                      .bloc<HomeSettingsBloc>()
                      .add(SaveSettings(state.homeSettingsModel));
                  context.bloc<LocationBloc>().add(ChangeLocationAndSettings());
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Unable to Save, Location Not Found",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.deepOrangeAccent,
                  ));
                }
              },
              child: Text(
                "Save",
                style: TextStyle(fontSize: 20),
              ),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            );
          },
        )
      ]);
}
