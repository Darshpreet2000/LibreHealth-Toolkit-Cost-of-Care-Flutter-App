import 'package:cost_of_care/bloc/view_cdm_statewise_screen_bloc/view_cdm_statewise_bloc.dart';
import 'package:cost_of_care/bloc/view_cdm_statewise_screen_bloc/view_cdm_statewise_event.dart';
import 'package:cost_of_care/bloc/view_cdm_statewise_screen_bloc/view_cdm_statewise_state.dart';
import 'package:cost_of_care/screens/view_cdm_statewise/components/state_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<ViewCdmStatewiseBloc>(context)
        .add(ViewCDMStatewiseFetchStates());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ViewCdmStatewiseBloc, ViewCdmStatewiseState>(
        listener: (BuildContext context, state) async {
      if (state is ViewCDMStatewiseErrorState) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            state.message,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepOrangeAccent,
        ));
      }
    }, child: BlocBuilder<ViewCdmStatewiseBloc, ViewCdmStatewiseState>(
            builder: (BuildContext context, ViewCdmStatewiseState state) {
      if (state is ViewCDMStatewiseLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ViewCDMStatewiseLoadedState) {
        return StateListTile(state.states);
      } else if (state is ViewCDMStatewiseErrorState) {
        return Center(
          child: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                state.message,
                style: TextStyle(fontSize: 18),
              )),
        );
      }

      return Container();
    }));
  }
}
