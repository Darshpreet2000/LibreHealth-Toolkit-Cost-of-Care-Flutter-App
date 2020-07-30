import 'package:curativecare/models/patient_experience.dart';
import 'package:flutter/material.dart';

class PatientSurveyWidget extends StatelessWidget {
  PatientExperience patientSurveyFirstHospital;

  PatientExperience patientSurveySecondHospital;


  PatientSurveyWidget(
      this.patientSurveyFirstHospital, this.patientSurveySecondHospital);

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
                    patientSurveyFirstHospital.communicationWithNursesPerformanceRate,
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
                    patientSurveySecondHospital.communicationWithNursesPerformanceRate,
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
                        patientSurveyFirstHospital.communicationWithDoctorsPerformanceRate,
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
                        patientSurveySecondHospital.communicationWithDoctorsPerformanceRate,
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
                        patientSurveyFirstHospital.communicationAboutMedicinesPerformanceRate,
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
                        patientSurveySecondHospital.communicationAboutMedicinesPerformanceRate,
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
                        patientSurveyFirstHospital.cleanlinessAndQuietnessOfHospitalEnvironmentPerformanceRate,
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
                        patientSurveySecondHospital.cleanlinessAndQuietnessOfHospitalEnvironmentPerformanceRate,
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
            "Patients who \"Strongly Agree\" they understood their care when they left the hospital",
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
                        patientSurveyFirstHospital.careTransitionPerformanceRate,
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
                        patientSurveySecondHospital.careTransitionPerformanceRate,

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
