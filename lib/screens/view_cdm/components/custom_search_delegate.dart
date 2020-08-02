import 'package:curativecare/bloc/search_screen_bloc/search_procedures/bloc.dart';
import 'package:curativecare/models/search_model.dart';
import 'package:curativecare/repository/search_screen_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'list_tile.dart';

class CustomSearchDelegate extends SearchDelegate {
  String hospitalName;

  CustomSearchDelegate(this.hospitalName);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear,color: Colors.black,),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }
  @override
  String get searchFieldLabel => 'Search procedures';

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back,color: Colors.black,),
      onPressed: () {
        close(context, null);

      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }
    SearchScreenBloc searchScreenBloc=new SearchScreenBloc(SearchScreenRepositoryImpl());

    searchScreenBloc.add(SearchInDatabaseFromViewCDMScreen(query,hospitalName));

    return   BlocBuilder<SearchScreenBloc, SearchScreenState>(
      cubit: searchScreenBloc,
        builder: (context,state) {
          if(state is SearchScreenLoadingState){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(child: CircularProgressIndicator()),
              ],
            );
          }
          else if(state is SearchScreenNoDataState){
            return  Container(
                      child: Center(
                        child: Text(
                          "No Results Found",style: TextStyle(fontSize: 18),
                    ),
                      ),
            );
          }
          else if(state is SearchScreenLoadedState) {
            List<SearchModel> hospitalResult=state.searchResult;
            return Scrollbar(
              child: ListView.builder(
                itemCount: hospitalResult.length,
                itemBuilder: (context, index) {
                  return makeCard(hospitalResult[index]);
                },
              ),
            );

          }
          else{
            return Container();
          }
        }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }
}