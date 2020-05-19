import 'package:flutter/material.dart';
import 'components/custom_app_bar_home.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[

          CustomAppBarHome(),
        ],
        overflow: Overflow.visible,
      ),
    );
  }
}
