import 'package:flutter/material.dart';

List<String> saved_list = [
  'Providence Alaska Medical Center',
  'North Star Behavorial Hospital',
  'UCLA Medical Center'
];

class SavedList extends StatefulWidget {
  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: saved_list.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(index);
        });
  }

  Card makeCard(int index) {
    return Card(
      elevation: 4.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[50]),
        child: makeListTile(index),
      ),
    );
  }

  ListTile makeListTile(int index) {
    return ListTile(
      title: Text(saved_list[index]),
      trailing: RaisedButton(
        color: Colors.indigo,
        onPressed: () {},
        child: Text(
          'View',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
