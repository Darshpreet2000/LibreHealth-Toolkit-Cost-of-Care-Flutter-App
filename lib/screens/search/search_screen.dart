import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SearchProcedure extends StatefulWidget {
  @override
  _SearchProcedureState createState() => _SearchProcedureState();
}

class _SearchProcedureState extends State<SearchProcedure> {
  bool incr,decr,std,drg;

  @override
  void initState() {
    incr=decr=std=drg=false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.blue[800],
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(-1.0, 1.0),
                      blurRadius: 4.0,
                      spreadRadius: 2.0)
                ],
              ),
              child: Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,

                    child:Container(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child:IconButton(
                          onPressed: () {Navigator.pop(context);},
                          icon:Icon(Icons.arrow_back,color: Colors.white,size: 25.0,)),
                    ),
                  ),
                  Expanded(
                    child:Align(

                        alignment: Alignment.bottomCenter,
                        child:Container(
                          margin: EdgeInsets.only(bottom: 10.0,right: 5.0,top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            autofocus: true,
                            decoration: InputDecoration(

                              contentPadding: EdgeInsets.all(15),
                              hintStyle: TextStyle(fontSize: 16,color: Colors.grey),
                              hintText: 'Search Procedures',
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.indigo[600],
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        )
                    ),
                  )
                ],
              ))
      ),

    );
  }
}