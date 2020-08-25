import 'package:cost_of_care/models/search_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget showList(List<SearchModel> searchResult) {
  return Scrollbar(
    child: ListView.builder(
      primary: false,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: searchResult.length,
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
  searchModel.name = searchModel.name.replaceAll('`', '');
  String charge = searchModel.charge == 0.0
      ? "N/A"
      : '\$ ' + searchModel.charge.toStringAsFixed(2);
  var color;
  if (searchModel.category == "Standard")
    color = Colors.indigo;
  else if (searchModel.category == "DRG")
    color = Colors.red;
  else
    color = Colors.green[700];
  return ListTile(
    title: Text(
      searchModel.description,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          searchModel.category,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: color),
        ),
        Text(
          searchModel.name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ),
    trailing: Text(
      charge,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
