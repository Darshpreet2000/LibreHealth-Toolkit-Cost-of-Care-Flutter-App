import 'package:curativecare/bloc/home_settings_bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/app_bar_settings.dart';
import 'components/body.dart';

class SettingsHome extends StatefulWidget {
  @override
  _SettingsHomeState createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> {
  static const Color appBackgroundColor = Color(0xFFf5f5f5);

  @override
  void initState() {
    context.bloc<HomeSettingsBloc>().add(GetInitialSettings());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeSettingsBloc, HomeSettingsState>(
        listener: (BuildContext context, HomeSettingsState state) {
      if (state is LoadingState) {}
    }, child: BlocBuilder<HomeSettingsBloc, HomeSettingsState>(
            builder: (BuildContext context, HomeSettingsState state) {
      return Scaffold(
          backgroundColor: appBackgroundColor,
          appBar: settingsAppBar(context, state),
          body: Body(state));
    }));
  }
}
