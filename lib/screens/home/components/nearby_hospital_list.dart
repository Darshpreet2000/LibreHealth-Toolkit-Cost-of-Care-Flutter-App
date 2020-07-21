import 'package:curativecare/bloc/location_bloc/location_bloc.dart';
import 'package:curativecare/bloc/location_bloc/user_location_state.dart';
import 'package:curativecare/bloc/nearby_hospital_bloc/bloc.dart';
import 'package:curativecare/models/hospitals.dart';
import 'package:curativecare/screens/home/components/list_tile.dart';
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
        }
        else if(state is LocationError){
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              state.message,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.deepOrangeAccent,
          ));
          context
              .bloc<NearbyHospitalBloc>()
              .add(NearbyHospitalShowError());
        }
      },
      child: BlocBuilder<NearbyHospitalBloc, NearbyHospitalState>(
        builder: (BuildContext context, NearbyHospitalState state) {
          if (state is NearbyHospitalsLoadingState) {
            return ShimmerLoading();
          } else if (state is NearbyHospitalsLoadedState) {
            return ListBuilder(state.nearby_hospital);
          } else if (state is NearbyHospitalsErrorState) {
            return Center(
                child: Text(
              state.message,
              style: TextStyle(fontSize: 18),
            ));
          }
        },
      ),
    );
  }
}

Widget ShimmerLoading() {
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
  List<Hospitals> items = new List();

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
