import 'package:curativecare/widgets/dash.dart';
import 'package:flutter/material.dart';

class UserLocation extends StatefulWidget {
   Color appBackgroundColor;

   UserLocation(this.appBackgroundColor);

  @override
  _UserLocationState createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {

  @override
  Widget build(BuildContext context) {
    return Container(
     color: Colors.grey[100],
      padding: EdgeInsets.only(top:10.0,left: 10,right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
           Row(
            children: <Widget>[
              Icon(Icons.location_on,color: Colors.grey,size: 24,),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'YOUR LOCATION',
                style: TextStyle(
                    color: Colors.grey,fontSize: 16.0,fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child:

               Container(
                   width: MediaQuery.of(context).size.width-20,
                child:Text(
                '643 New York Ave NW, Washington, DC 200',
                style: TextStyle(
                    color: Colors.black,fontSize: 16.0, fontWeight: FontWeight.bold
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                  softWrap: false,
              ),
              )
    ),
            ],
          ),
        Padding(
         padding: const EdgeInsets.only(top:8.0),
         child:
          Dash(length: MediaQuery.of(context).size.width-20, dashColor: Colors.blue,dashThickness: 4,dashLength: 15,)
          )
         ],
      ),
    );
  }
}
