
import 'package:flutter/material.dart';

class PatientSurveyWidget extends StatelessWidget {
  final List<List<dynamic>> patientExperienceList;

  PatientSurveyWidget(this.patientExperienceList);

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
            "Mortality national comparison",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          IntrinsicHeight(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: mortaityCompare())),
          SizedBox(
            height: 5,
          ),
          Text(
            "Safety of care national comparison",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          IntrinsicHeight(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: safetyCompare())),
          SizedBox(
            height: 5,
          ),
          Text(
            "Readmission national comparison",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          IntrinsicHeight(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: readmissionCompare())),
          SizedBox(
            height: 5,
          ),
          Text(
            "Patient experience national comparison",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          IntrinsicHeight(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: patientExperienceCompare())),
          SizedBox(
            height: 5,
          ),
          Text(
            "Effectiveness of care national comparison",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          IntrinsicHeight(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: effectiveCareCompare()))
        ]);
  }

  List<Widget> mortaityCompare() {
    List listings = List<Widget>();
    for (int i = 0; i < patientExperienceList.length; i++) {
      listings.add(Expanded(
        child: Text(
          patientExperienceList[i][8],
          style: TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
        ),
      ));

      if (i != patientExperienceList.length - 1)
        listings.add(VerticalDivider(
          thickness: 2,
          width: 20,
          color: Colors.grey[400],
        ));
    }
    return listings;
  }

  List<Widget> safetyCompare() {
    List listings = List<Widget>();
    for (int i = 0; i < patientExperienceList.length; i++) {
      listings.add(Expanded(
        child: Text(
          patientExperienceList[i][9],
          style: TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
        ),
      ));

      if (i != patientExperienceList.length - 1)
        listings.add(VerticalDivider(
          thickness: 2,
          width: 20,
          color: Colors.grey[400],
        ));
    }
    return listings;
  }

  List<Widget> readmissionCompare() {
    List listings = List<Widget>();
    for (int i = 0; i < patientExperienceList.length; i++) {
      listings.add(Expanded(
        child: Text(
          patientExperienceList[i][10],
          style: TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
        ),
      ));

      if (i != patientExperienceList.length - 1)
        listings.add(VerticalDivider(
          thickness: 2,
          width: 20,
          color: Colors.grey[400],
        ));
    }
    return listings;
  }

  List<Widget> patientExperienceCompare() {
    List listings = List<Widget>();
    for (int i = 0; i < patientExperienceList.length; i++) {
      listings.add(Expanded(
        child: Text(
          patientExperienceList[i][11],
          style: TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
        ),
      ));

      if (i != patientExperienceList.length - 1)
        listings.add(VerticalDivider(
          thickness: 2,
          width: 20,
          color: Colors.grey[400],
        ));
    }
    return listings;
  }

  List<Widget> effectiveCareCompare() {
    List listings = List<Widget>();
    for (int i = 0; i < patientExperienceList.length; i++) {
      listings.add(Expanded(
        child: Text(
          patientExperienceList[i][12],

          style: TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
        ),
      ));

      if (i != patientExperienceList.length - 1)
        listings.add(VerticalDivider(
          thickness: 2,
          width: 20,
          color: Colors.grey[400],
        ));
    }
    return listings;
  }
}
