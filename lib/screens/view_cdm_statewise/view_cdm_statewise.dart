import 'package:flutter/material.dart';

import 'components/body.dart';

class ViewCDMStatewise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View CDM Statewise'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Body(),
    );
  }
}
