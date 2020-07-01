import 'package:flutter/material.dart';

class ReportIssue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report a Bug'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        child: Center(child: Text('Pending for now')),
      ),
    );
  }
}
