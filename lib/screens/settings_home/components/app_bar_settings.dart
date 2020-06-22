import 'package:curativecare/bloc/home_settings_bloc/bloc.dart';
import 'package:curativecare/bloc/location_bloc/location_bloc.dart';
import 'package:curativecare/bloc/location_bloc/user_location_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

AppBar settingsAppBar(BuildContext context,HomeSettingsState state) {

  return AppBar(
      title: Text(
        'Settings',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: Colors.indigo,
      actions: <Widget>[
        // action button
        IconButton(
          icon: Icon(
            Icons.save,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            if(state is LoadedState)
              context.bloc<HomeSettingsBloc>().add(SaveSettings(state.homeSettingsModel));
              context.bloc<LocationBloc>().add(RefreshLocation());
          },
        ),
      ]);
}