import 'package:flutter/material.dart';
import 'components/app_bar_home.dart';
import 'components/body.dart';

class Home extends StatefulWidget {
   Home(this.drawerKey);

  GlobalKey<ScaffoldState>  drawerKey ;

  @override
  _HomeState createState() => _HomeState();


}

class _HomeState extends State<Home> {

  static const Color appBackgroundColor = Color(0xFFFFF7EC);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: Column(
        children: <Widget>[

          AppBarHome(widget.drawerKey),

          SizedBox(height: 5,),
          Expanded(
            child:Body()
          ),
        ],
      ),

    );
  }

}
