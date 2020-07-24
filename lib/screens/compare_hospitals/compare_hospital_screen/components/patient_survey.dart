import 'package:flutter/material.dart';

class PatientSurvey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: Text(
          "Patient Survey & Experience",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
          size: 30,
        ),
        children: <Widget>[
          Text(
            "Patients who reported that their nurses Always communicated well",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          IntrinsicHeight(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                Expanded(
                  child: Text(
                    "74%",
                    style: TextStyle(fontSize: 18,),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                ),
                VerticalDivider(
                  thickness: 2,
                  width: 20,
                  color: Colors.grey[400],
                ),
                Expanded(
                  child: Text(
                    "N/A",
                    style: TextStyle(fontSize: 18, ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                )
              ])),
          SizedBox(
            height: 5,
          ),

          Text(
            "Patients who reported that their doctors Always communicated well",
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          IntrinsicHeight(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "80%",
                        style: TextStyle(fontSize: 18, ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2,
                      width: 20,
                      color: Colors.grey[400],
                    ),
                    Expanded(
                      child: Text(
                        "76%",
                        style: TextStyle(fontSize: 18, ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    )
                  ])),

          SizedBox(
            height: 5,
          ),

          Text(
            "Patients who reported that staff Always explained about medicines before giving it to them",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          IntrinsicHeight(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "66%",
                        style: TextStyle(fontSize: 18, ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2,
                      width: 20,
                      color: Colors.grey[400],
                    ),
                    Expanded(
                      child: Text(
                        "47%",
                        style: TextStyle(fontSize: 18,),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    )
                  ])),
          SizedBox(
            height: 5,
          ),

          Text(
            "Patients who reported that their room and bathroom were Always clean",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          IntrinsicHeight(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "90%",
                        style: TextStyle(fontSize: 18,),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2,
                      width: 20,
                      color: Colors.grey[400],
                    ),
                    Expanded(
                      child: Text(
                        "94%",
                        style: TextStyle(fontSize: 18,),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    )
                  ])),
          SizedBox(
            height: 5,
          ),

          Text(
            "Patients who reported that the area around their room was Always quiet at night",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          IntrinsicHeight(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "99%",
                        style: TextStyle(fontSize: 18, ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2,
                      width: 20,
                      color: Colors.grey[400],
                    ),
                    Expanded(
                      child: Text(
                        "89%",
                        style: TextStyle(fontSize: 18, ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    )
                  ]))
        ]);
  }
}
