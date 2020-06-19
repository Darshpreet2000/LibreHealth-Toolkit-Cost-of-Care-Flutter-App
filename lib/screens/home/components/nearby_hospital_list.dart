import 'package:curativecare/bloc/location_bloc/location_bloc.dart';
import 'package:curativecare/bloc/location_bloc/user_location_state.dart';
import 'package:curativecare/bloc/nearby_hospital_bloc/bloc.dart';
import 'package:curativecare/models/nearby_hospital.dart';
import 'package:curativecare/screens/home/components/list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearbyHospitalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocListener<LocationBloc, LocationState>(
      listener: (BuildContext context, state) {
        if (state is LocationLoaded) {
          context.bloc<NearbyHospitalBloc>().add(FetchHospitals());
        }
      },
      child: BlocBuilder<NearbyHospitalBloc, NearbyHospitalState>(
        builder: (BuildContext context, NearbyHospitalState state) {
          if (state is LoadingState) {
            return ShimmerLoading();
          } else if (state is LoadedState) {
            return ListBuilder(state.nearby_hospital);
          } else if (state is ErrorState) {
            return Center(child: Text(state.message,style: TextStyle(fontSize: 18),));
          }
        },
      ),
    ));
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

class ListBuilder extends StatefulWidget {
  List<NearbyHospital> original;

  ListBuilder(this.original);

  @override
  _ListBuilderState createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  List<NearbyHospital> items = new List();

  @override
  void initState() {
    items = widget.original;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(items[index]);
      },
    );
  }
}
