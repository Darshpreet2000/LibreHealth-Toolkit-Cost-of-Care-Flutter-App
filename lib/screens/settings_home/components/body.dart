import 'package:cost_of_care/bloc/home_settings_bloc/bloc.dart';
import 'package:cost_of_care/models/home_settings_model.dart';
import 'package:cost_of_care/screens/settings_home/components/choose_location_button.dart';
import 'package:cost_of_care/widgets/user_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatelessWidget {
  final HomeSettingsLoadedState state;
  final UserLocation userLocationWidget;

  Body(this.state, this.userLocationWidget);

  static const Color appBackgroundColor = Color(0xFFf5f5f5);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Search by Radius',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Distance',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${state.homeSettingsModel.radius} Km',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            RadiusSlider(state),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Order By',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Ordering by ${state.homeSettingsModel.order}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Switch(
                      value: state.homeSettingsModel.isSelected,
                      onChanged: (bool value) {
                        context.bloc<HomeSettingsBloc>().add(ToggleOrder(
                            HomeSettingsModel(
                                state.homeSettingsModel.radius,
                                state.homeSettingsModel.order,
                                value,
                                state.homeSettingsModel.latitude,
                                state.homeSettingsModel.longitude,
                                state.homeSettingsModel.address,
                                state.homeSettingsModel.state)));
                      },
                      activeTrackColor: Colors.pinkAccent[100],
                      activeColor: Colors.pink,
                    )
                  ],
                ),
              ),
            ),
            userLocationWidget,
            Container(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Choose a different location',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            LocationButton(state)
          ],
        ),
      ),
    );
  }
}

class RadiusSlider extends StatelessWidget {
  final HomeSettingsLoadedState state;

  RadiusSlider(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Radius',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              new Expanded(
                  child: Slider(
                value: state.homeSettingsModel.radius.toDouble(),
                min: 1.0,
                max: 50.0,
                divisions: 50,
                activeColor: Colors.pinkAccent,
                inactiveColor: Colors.grey[200],
                label: '${state.homeSettingsModel.radius}',
                onChanged: (double newValue) {
                  context.bloc<HomeSettingsBloc>().add(ChangeRadius(
                      HomeSettingsModel(
                          newValue.toInt(),
                          state.homeSettingsModel.order,
                          state.homeSettingsModel.isSelected,
                          state.homeSettingsModel.latitude,
                          state.homeSettingsModel.longitude,
                          state.homeSettingsModel.address,
                          state.homeSettingsModel.state)));
                },
              )),
            ])),
      ),
    );
  }
}
