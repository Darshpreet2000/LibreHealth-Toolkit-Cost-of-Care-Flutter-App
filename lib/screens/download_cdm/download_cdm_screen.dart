import 'package:flutter/material.dart';

import '../../main.dart';
import 'components/body.dart';

class DownloadCDMScreen extends StatelessWidget {
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
