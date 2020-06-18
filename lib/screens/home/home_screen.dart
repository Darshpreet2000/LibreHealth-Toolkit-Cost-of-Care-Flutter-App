import 'package:curativecare/bloc/location_bloc/location_bloc.dart';
import 'package:curativecare/bloc/location_bloc/user_location_state.dart';
import 'package:curativecare/repository/location_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocProvider(
        create: (_) => LocationBloc(Location_Repository()),
    child: BlocBuilder<LocationBloc, LocationState>(builder: (_, theme) {
    return  Scaffold(
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
    )
    );
  }

}
