import 'package:curativecare/screens/search/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SearchProcedure extends StatefulWidget {
  @override
  _SearchProcedureState createState() => _SearchProcedureState();
}

class _SearchProcedureState extends State<SearchProcedure> {

  final TextEditingController _searchQuery = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: TextField(
          autofocus: true,
          controller: _searchQuery,
          decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              border: InputBorder.none,

              prefixIcon:
                 Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
              hintText: "Search Procedures...",
              hintStyle: TextStyle(color: Colors.grey)),
        ) ,
      ),
      body: Body(),
    );
  }
}



