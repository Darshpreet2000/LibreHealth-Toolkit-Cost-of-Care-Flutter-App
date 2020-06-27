import 'package:flutter/material.dart';
import 'components/body.dart';
class ViewCDM extends StatelessWidget {
  String name;

  ViewCDM(this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text(name,style: TextStyle(color: Colors.white,),),
      ),
      body: Body(name),
    );
  }
}
