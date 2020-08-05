import 'package:curativecare/screens/download_cdm/download_cdm_screen.dart';
import 'package:curativecare/screens/view_cdm_statewise/components/cdm_list_tile.dart';
import 'package:flutter/material.dart';

class StateListTile extends StatelessWidget {
  List<String> states;

  StateListTile(this.states);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
          itemCount: states.length,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(context, index);
          }),
    );
  }

  Card makeCard(BuildContext context, int index) {
    return Card(
      elevation: 4.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[50]),
        child: makeListTile(context, index),
      ),
    );
  }

  ListTile makeListTile(BuildContext context, int index) {
    return ListTile(
      title: Text(states[index],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Source',
            fontWeight: FontWeight.w600,
            fontSize: 18,
          )),
      trailing: RaisedButton(
        color: Colors.indigo,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CDMListTile(states[index]),
              ));
        },
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
