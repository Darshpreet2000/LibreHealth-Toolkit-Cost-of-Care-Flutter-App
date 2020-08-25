import 'package:cost_of_care/screens/search/search_screen.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class ViewCDM extends StatefulWidget {
  final String name;

  ViewCDM(this.name);

  @override
  _ViewCDMState createState() => _ViewCDMState();
}

class _ViewCDMState extends State<ViewCDM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orange,
          centerTitle: true,
          leading: BackButton(color: Colors.white),
          title: Text(
            widget.name,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchProcedure(widget.name)),
                );
              },
            ),
          ]),
      body: Body(widget.name),
    );
  }
}
