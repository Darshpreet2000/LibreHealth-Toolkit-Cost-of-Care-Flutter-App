import 'package:curativecare/bloc/search_screen_bloc/search_procedures/search_screen_bloc.dart';
import 'package:curativecare/bloc/view_cdm_screen_bloc/view_cdm_screen_bloc.dart';
import 'package:curativecare/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/body.dart';

class ViewCDM extends StatefulWidget {
  String name;

  ViewCDM(this.name);

  @override
  _ViewCDMState createState() => _ViewCDMState();
}

class _ViewCDMState extends State<ViewCDM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.indigo,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
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
