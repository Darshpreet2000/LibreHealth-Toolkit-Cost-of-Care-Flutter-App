import 'package:flutter/material.dart';

List<String> states = ['California', 'Indiana', 'New York', 'Alaska'];

class StateList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: states.length,
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
      title: Text(states[index]),
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
