import 'package:flutter/material.dart';
import '../../main.dart';
import 'components/body.dart';

class DownloadCDMScreen extends StatefulWidget {
  @override
  _DownloadCDMScreenState createState() => _DownloadCDMScreenState();
}

class _DownloadCDMScreenState extends State<DownloadCDMScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Download ChargeMasters',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Body(box.get('state')),
    );
  }
}
