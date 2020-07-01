import 'package:curativecare/screens/view_cdm/view_cdm.dart';
import 'package:flutter/material.dart';

class SavedList extends StatelessWidget {
  List<String> hospitalNames;

  SavedList(this.hospitalNames);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: hospitalNames.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(context, index);
        });
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
      title: Text(
        hospitalNames[index],
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Source',
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      trailing: RaisedButton(
        color: Colors.indigo,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewCDM(hospitalNames[index])),
          );
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
