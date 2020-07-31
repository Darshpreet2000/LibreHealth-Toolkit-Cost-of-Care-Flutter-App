import 'package:curativecare/widgets/star_widget.dart';
import 'package:flutter/material.dart';

class GeneralInformation extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  return    ExpansionTile(
    title: Text(
      "General Information",
      style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold
      ),
    ),
    trailing: Icon(Icons.keyboard_arrow_down,color: Colors.black,size: 30,),
    children: <Widget>[

      Text("Overall Rating",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),

      SizedBox(height: 5,),
      IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            Expanded(
                child:Center(
                  child: IconTheme(
                    data: IconThemeData(
                      color: Colors.amber,
                      size: 30,
                    ),
                    child: StarDisplay(value: 4),
                  ),
                ),
            ),
            VerticalDivider(
              thickness: 2,
              width: 20,
              color: Colors.grey[400],
            ),
            Expanded(
              child:Center(
                child: IconTheme(
                  data: IconThemeData(
                    color: Colors.amber,
                    size: 30,
                  ),
                  child: StarDisplay(value: 3),
                ),
              ),
            )
          ],
        ),
      ),
      SizedBox(height: 5,),
      Text("Hospital Type",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 5,),

      IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Text("Psychiatric",
                style: TextStyle(fontSize: 18,),
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
              child: Text("Acute Care - Department Of Defense",
                style: TextStyle(fontSize: 18,),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,),
            )
          ],
        ),
      ),
      SizedBox(height: 5,),

      Text("Provides emergency services",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 5,),

      IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            Expanded(
              child: Text("Yes",
                style: TextStyle(fontSize: 18, ),
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
              child: Text("No",
                style: TextStyle(fontSize: 18, ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,),
            )
          ],
        ),
      ),
      SizedBox(height: 5,),

      Text("Able to receive lab results electronically",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 5,),

      IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            Expanded(
              child: Text("Yes",
                style: TextStyle(fontSize: 18, ),
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
              child: Text("Not Available",
                style: TextStyle(fontSize: 18, ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,),
            )
          ],
        ),
      ),
      SizedBox(height: 5,),

      Text("Able to track patient's lab results, tests, and referrals electronically between visits",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 5,),

      IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            Expanded(
              child: Text("Yes",
                style: TextStyle(fontSize: 18,),
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
              child: Text("Not Available",
                style: TextStyle(fontSize: 18, ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,),
            )
          ],
        ),
      ),
      SizedBox(height: 5,),

    ],
  );
  }
}