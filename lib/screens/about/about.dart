import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About App'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        child: Center(child: Text('Pending for now')),
      ),
    );
  }
}
