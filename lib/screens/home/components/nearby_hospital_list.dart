import 'package:curativecare/models/nearby_hospital.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class NearbyHospitalList extends StatefulWidget {
  @override
  _NearbyHospitalListState createState() => _NearbyHospitalListState();
}
List<NearbyHospital> hospitals=[ NearbyHospital('Providence Alaska Medical Center', 'assets/show.jpg', '5384.8 mi','40'),
  NearbyHospital('North Star Behavorial Hospital', 'assets/download.jpg', '7984.8 mi','250'),
  NearbyHospital('UCLA Medical Center', 'assets/ucla.jpg', '9384.8 mi','120'),
  NearbyHospital('University of Michigan', 'assets/show.jpg', '3384.8 mi','400'),];


class _NearbyHospitalListState extends State<NearbyHospitalList> {
   String output="";
  @override
  Widget build(BuildContext context) {
    return Container(


        child: ListView.builder(
          primary: false,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,

          itemCount: hospitals.length,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(index);
          },
        ),

    );
  }

}

 Card makeCard(int index){
    return Card(
      elevation: 4.0,

      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(

        decoration: BoxDecoration(color: Colors.grey[50]),
        child: makeListTile(index),
      ),
    );
  }


Container makeListTile(int index) {
  return Container(
    height: 130,

    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      boxShadow: [
        BoxShadow(
            color: Colors.grey,
            offset: Offset(-1.0, 1.0),
            blurRadius: 4.0,
            spreadRadius: 1.0)
      ],
    ),
    child:Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10,top: 16,bottom: 16,right: 10),
          width: 100,
          decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(hospitals[index].path),
                fit: BoxFit.cover,
              ),
            border:  Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        ),

      Expanded(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
         children: <Widget>[
           Expanded(
               child:Padding(
                 padding: const EdgeInsets.only( top:8),
                 child: Text(hospitals[index].name,
                   maxLines: 2,
                   overflow: TextOverflow.ellipsis,
                   style: TextStyle(
                     color: Colors.black,
                     fontFamily: 'Source',
                     fontWeight: FontWeight.w600,
                     fontSize: 18,
                   ),

                 ),
               )
           ),

           Row(

             mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: <Widget>[
            Text('BEDS',style: TextStyle(
                fontSize: 14)),

            Row(
           children: <Widget>[
             Text('DISTANCE',style: TextStyle(
                 fontSize: 14
             ),),
             SizedBox(
               width: 8,
             )
           ],
            )
          ],
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
               Text(hospitals[index].beds,style: TextStyle(
                   fontSize: 14
               ),),

               Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: <Widget>[

                   Container(
                     height: 45,
                     width: 45,
                     child: Image.asset('assets/distance_icon.png'),
                   ),

                   Text(hospitals[index].distance,style: TextStyle(
                       fontSize: 14
                   ),),

                   SizedBox(
                     width: 8,
                   )
                 ],
               ),
             ],
           )
         ],
       )
      )
      ],
    )
  );
}
