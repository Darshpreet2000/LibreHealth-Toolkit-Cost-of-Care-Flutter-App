import 'package:flutter/material.dart';
import 'components/body.dart';

class ViewCDMStatewise extends StatefulWidget {
  @override
  _ViewCDMStatewiseState createState() => _ViewCDMStatewiseState();
}

class _ViewCDMStatewiseState extends State<ViewCDMStatewise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View CDM Statewise'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        leading: BackButton(color: Colors.white),
      ),
      body: Body(),
    );
  }
}
