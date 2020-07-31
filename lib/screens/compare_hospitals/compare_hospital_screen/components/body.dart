import 'package:curativecare/screens/compare_hospitals/compare_hospital_screen/components/general_information.dart';
import 'package:curativecare/screens/compare_hospitals/compare_hospital_screen/components/patient_survey.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return SingleChildScrollView(
       child: Container(
           padding: const EdgeInsets.symmetric(horizontal: 8.0),
         child: Column(
           children: <Widget>[
             IntrinsicHeight(
               child: Row(
                 mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                 children: <Widget>[
                   Expanded(
                     child: Text("ALASKA PSYCHIATRIC INSTITUTE",
                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                       textAlign: TextAlign.center,
                       overflow: TextOverflow.ellipsis,
                       maxLines: 4,),
                   ),
                   VerticalDivider(
                     thickness: 2,
                     width: 20,
                     color: Colors.grey[400],
                   ),
                   Expanded(
                     child: Text("BARTLETT REGIONAL HOSPITAL",
                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                       textAlign: TextAlign.center,
                       overflow: TextOverflow.ellipsis,
                       maxLines: 4,
                     ),
                   )
                 ],
               ),
             ),
             SizedBox(height: 8,),
             IntrinsicHeight(
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: <Widget>[
                   Expanded(
                     child: Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(10)),
                       ),

                       child: new FittedBox(
                           fit: BoxFit.fill,
                           child: Image.asset('assets/show.jpg')),
                     ),
                   ),
                   VerticalDivider(
                     thickness: 2,
                     width: 20,
                     color: Colors.grey[400],

                   ),
                   Expanded(
                     child: Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(10)),
                       ),
                       child: new FittedBox(
                           fit: BoxFit.fill,
                           child: Image.asset('assets/ucla.jpg')
                       ),
                     ),
                   )
                 ],
               ),
             ),
             SizedBox(height: 5,),
              GeneralInformation(),
             PatientSurvey(),
       ]
         )
       ),
     );
  }

}