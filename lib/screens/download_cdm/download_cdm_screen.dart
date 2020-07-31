import 'package:curativecare/bloc/search_screen_bloc/search_procedures/search_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
class DownloadCDMScreen extends StatefulWidget {

  @override
  _DownloadCDMScreenState createState() => _DownloadCDMScreenState();
}

class _DownloadCDMScreenState extends State<DownloadCDMScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          'Download ChargeMasters',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: Body(),
    );
  }


}
