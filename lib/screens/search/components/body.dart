import 'package:curativecare/bloc/search_screen_bloc/bottom_sheet/bloc.dart';
import 'package:curativecare/bloc/search_screen_bloc/search_procedures/search_screen_bloc.dart';
import 'package:curativecare/bloc/search_screen_bloc/search_procedures/search_screen_event.dart';
import 'package:curativecare/bloc/search_screen_bloc/search_procedures/search_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'list_tile.dart';

class Body extends StatefulWidget {
  TextEditingController _searchQuery = TextEditingController();
  SearchScreenBloc searchScreenBloc;

  Body(this._searchQuery, this.searchScreenBloc);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<BottomSheetBloc, BottomSheetState>(
      listener: (BuildContext context, BottomSheetState state) {
        if (state is BottomSheetSaved && widget._searchQuery.text.length > 0) {
          widget.searchScreenBloc
              .add(SearchInDatabase(widget._searchQuery.text));
        }
      },
      child: BlocBuilder(
        cubit: widget.searchScreenBloc,
        builder: (BuildContext context, SearchScreenState state) {
          if (state is SearchScreenLoadingState) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is SearchScreenNoDataState) {
            return Container(
              child: Center(
                child: Text(
                  "No Data Found",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            );
          } else if (state is SearchScreenLoadedState) {
            return showList(state.searchResult);
          } else {
            return Container(
              child: Center(
                  child: Text(
                'Enter Procedure to Search',
                style: TextStyle(fontSize: 18),
              )),
            );
          }
        },
      ),
    );
  }
}
