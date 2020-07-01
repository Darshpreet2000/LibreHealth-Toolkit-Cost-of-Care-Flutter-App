import 'package:curativecare/models/search_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget showList(List<SearchModel> searchResult){
  return Scrollbar(
    child: ListView.builder(
      primary: false,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount:  searchResult.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(searchResult[index]);
      },
    ),
  );
}

Card makeCard(SearchModel searchModel) {
  return Card(
    elevation: 4.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Colors.grey[50]),
      child: makeListTile(searchModel),
    ),
  );
}

ListTile makeListTile(SearchModel searchModel) {
  searchModel.charge=searchModel.charge.length>10?"N/A":searchModel.charge;
  searchModel.name = searchModel.name.replaceAll('_', ' ');
  return ListTile(
    title: Text(
      searchModel.description,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          searchModel.category,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          searchModel.name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    ),
    isThreeLine: true,
    trailing: Text(
      searchModel.charge + ' \$',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  );
}