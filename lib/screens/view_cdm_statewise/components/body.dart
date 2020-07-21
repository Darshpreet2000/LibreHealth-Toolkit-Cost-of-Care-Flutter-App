import 'package:curativecare/bloc/view_cdm_statewise_screen_bloc/view_cdm_statewise_bloc.dart';
import 'package:curativecare/bloc/view_cdm_statewise_screen_bloc/view_cdm_statewise_event.dart';
import 'package:curativecare/bloc/view_cdm_statewise_screen_bloc/view_cdm_statewise_state.dart';
import 'package:curativecare/screens/view_cdm_statewise/components/state_list_tile.dart';
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
    return BlocBuilder<ViewCdmStatewiseBloc, ViewCdmStatewiseState>(
        builder: (BuildContext context, ViewCdmStatewiseState state) {
      if (state is ViewCDMStatewiseLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ViewCDMStatewiseLoadedState) {

        return StateListTile(state.states);
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
