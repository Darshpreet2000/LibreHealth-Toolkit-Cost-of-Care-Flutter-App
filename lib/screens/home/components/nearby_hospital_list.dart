import 'package:cost_of_care/bloc/compare_screen_bloc/compare_screen_list/compare_screen_list_bloc.dart';
import 'package:cost_of_care/bloc/compare_screen_bloc/compare_screen_list/compare_screen_list_event.dart';
import 'package:cost_of_care/bloc/location_bloc/location_bloc.dart';
import 'package:cost_of_care/bloc/location_bloc/user_location_state.dart';
import 'package:cost_of_care/bloc/nearby_hospital_bloc/bloc.dart';
import 'package:cost_of_care/models/hospitals.dart';
import 'package:cost_of_care/screens/home/components/list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';

class NearbyHospitalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationBloc, LocationState>(
      listener: (BuildContext context, state) {
        if (state is LocationLoaded) {
          String state = box.get('state');
          context.bloc<NearbyHospitalBloc>().add(FetchHospitals(state));
          //Compare hospital bloc
          context
              .bloc<CompareScreenListBloc>()
              .add(CompareScreenListFetchHospitalName());
        } else if (state is LocationError) {
          context
              .bloc<NearbyHospitalBloc>()
              .add(NearbyHospitalShowError(state.message));
        }
      },
      child: BlocBuilder<NearbyHospitalBloc, NearbyHospitalState>(
        builder: (BuildContext context, NearbyHospitalState state) {
          if (state is NearbyHospitalsLoadingState) {
            return shimmerLoading();
          } else if (state is NearbyHospitalsLoadedState) {
            return ListBuilder(state.nearbyHospital);
          } else if (state is NearbyHospitalsErrorState) {
            return Container(
              padding: EdgeInsets.all(8),
              child: Center(
                  child: Text(
                state.message,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              )),
            );
          }

          return Container();
        },
      ),
    );
  }
}

Widget shimmerLoading() {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: 6,
    itemBuilder: (BuildContext context, int index) {
      return Card(
        elevation: 4.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.grey[50]),
          child: makeShimmerListTile(context, index),
        ),
      );
    },
  );
}

class ListBuilder extends StatelessWidget {
  final List<Hospitals> items;

  ListBuilder(this.items);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: items.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(items[index]);
        },
      ),
    );
  }
}
