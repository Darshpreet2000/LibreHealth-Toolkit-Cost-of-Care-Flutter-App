import 'package:flutter/material.dart';

class ShareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share App'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        child: Center(
            child: Text('Pending for now')

        ),
      ),
    );
  }
}
