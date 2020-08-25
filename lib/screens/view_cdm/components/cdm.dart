import 'package:cost_of_care/bloc/view_cdm_screen_bloc/bloc.dart';
import 'package:cost_of_care/models/search_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'list_tile.dart';

class CDM extends StatefulWidget {
  final String name;

  CDM(this.name);

  @override
  _CDMState createState() => _CDMState();
}

class _CDMState extends State<CDM> {
  @override
  void initState() {
    super.initState();
    context.bloc<ViewCdmScreenBloc>().add(LoadCdm(widget.name));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewCdmScreenBloc, ViewCdmScreenState>(
      builder: (BuildContext context, ViewCdmScreenState state) {
        if (state is LoadingViewCdmScreenState) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is LoadedViewCdmScreenState) {
          return showList(state.cdmList);
        } else if (state is ErrorViewCdmScreenState) {
          return Container(
            padding: EdgeInsets.all(8),
            child: Center(
              child: Text(state.message),
            ),
          );
        }

        return Container();
      },
    );
  }

  Widget showList(List<SearchModel> cdmList) {
    return Scrollbar(
      child: ListView.builder(
          itemCount: cdmList.length,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(cdmList[index]);
          }),
    );
  }
}
