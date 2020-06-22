import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future LoadingWidget(BuildContext context){
   return showDialog(context: context,
       barrierDismissible: true,
        builder: (BuildContext context){
     return AlertDialog(
        content: Container(
          child: Row(
            children: <Widget>[
              CircularProgressIndicator(),
               SizedBox(width: 20,),
              Text('Please Wait...')
            ],
          ),
        ),
     );
       }
   );
}