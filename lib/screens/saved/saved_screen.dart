import 'package:flutter/material.dart';

import 'components/alert_dialog.dart';
import 'components/body.dart';

class Saved extends StatefulWidget {
  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(
            'Saved ChargeMasters',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: InkWell(
                  onTap: () {
                    showRefreshDialog(context);
                  },
                  child: Icon(
                    Icons.refresh,
                    size: 26.0,
                    color: Colors.white,
                  ),
                )),
          ],
        ),
        body: Body());
  }
}
