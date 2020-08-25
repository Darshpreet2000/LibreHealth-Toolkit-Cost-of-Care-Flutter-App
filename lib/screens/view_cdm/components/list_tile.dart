import 'package:cost_of_care/models/search_model.dart';
import 'package:flutter/material.dart';

Card makeCard(SearchModel cdm) {
  return Card(
    elevation: 4.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Colors.grey[50]),
      child: makeListTile(cdm),
    ),
  );
}

ListTile makeListTile(SearchModel cdm) {
  String charge =
      cdm.charge == 0.0 ? "N/A" : '\$ ' + cdm.charge.toStringAsFixed(2);
  var color;
  if (cdm.category == "Standard")
    color = Colors.orange;
  else if (cdm.category == "DRG")
    color = Colors.red;
  else
    color = Colors.green[700];
  return ListTile(
    title: Text(
      cdm.description,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      cdm.category,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color),
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
