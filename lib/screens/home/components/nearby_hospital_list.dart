import 'package:curativecare/bloc/location_bloc/location_bloc.dart';
import 'package:curativecare/bloc/location_bloc/user_location_state.dart';
import 'package:curativecare/bloc/nearby_hospital_bloc/bloc.dart';
import 'package:curativecare/models/nearby_hospital.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class NearbyHospitalList extends StatefulWidget {
  @override
  _NearbyHospitalListState createState() => _NearbyHospitalListState();
}
List<NearbyHospital> hospitals=new List();

class _NearbyHospitalListState extends State<NearbyHospitalList> {
  String output="";

   @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocListener<LocationBloc, LocationState>(
          listener: (BuildContext context, state) {
            if(state is LocationLoaded){
              context.bloc<NearbyHospitalBloc>().add(FetchHospitals());
            }
          },
          child: BlocBuilder<NearbyHospitalBloc, NearbyHospitalState>(
            builder: (BuildContext context, NearbyHospitalState state) {
                if(state is  LoadingState){
                  return CircularProgressIndicator();
                }
                else if (state is LoadedState){
                  hospitals=state.nearby_hospital;
                  return ListBuilder(state.nearby_hospital);
                }
                else if (state is ErrorState){
                  return Text(state.message);
                }
            },
          ),
        )

    );
  }

}

Widget ListBuilder(List<NearbyHospital> hospitals){
  return ListView.builder(
    primary: false,
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: hospitals.length,
    itemBuilder: (BuildContext context, int index) {
      return makeCard(index);
    },
  );
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
                image: new AssetImage('assets/show.jpg'),
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
