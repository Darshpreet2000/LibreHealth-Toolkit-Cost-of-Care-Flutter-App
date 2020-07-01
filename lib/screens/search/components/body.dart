import 'package:curativecare/bloc/search_screen_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'list_tile.dart';


class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchScreenBloc, SearchScreenState>(
      builder: (BuildContext context, SearchScreenState state) {
        if(state is SearchScreenLoadingState){
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        else if(state is SearchScreenNoDataState){
          return Container(
            child: Center(
              child: Text("No Data Found"),
            ),
          );
        }
       else if(state is SearchScreenLoadedState){
         return showList(state.searchResult);
        }
       else{
         return Container(
           child: Center(
            child: Text('Enter Procedure to Search',
              style: TextStyle(
                fontSize: 18
              ),
             )
           ),
         );
        }
      },
    );
  }

  @override
  void dispose() {
    context.bloc<SearchScreenBloc>().close();
  }
}

