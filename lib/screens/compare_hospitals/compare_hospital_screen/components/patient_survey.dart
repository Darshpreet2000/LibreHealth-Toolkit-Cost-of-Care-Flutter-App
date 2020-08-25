import 'package:cost_of_care/models/patient_experience.dart';
import 'package:flutter/material.dart';

class PatientSurveyWidget extends StatelessWidget {
  final List<PatientExperience> patientExperienceList;

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
            "Patients who reported that their nurses Always communicated well",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          IntrinsicHeight(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: getNurseCommunication())),
          SizedBox(
            height: 5,
          ),
          Text(
            "Patients who reported that their doctors Always communicated well",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          IntrinsicHeight(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: getDoctorCommunication())),
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
                  children: getStaffMedicineExplain())),
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
                  children: getCleanQuiet())),
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
                  children: getAgreeCare()))
        ]);
  }

  List<Widget> getNurseCommunication() {
    List listings = List<Widget>();
    for (int i = 0; i < patientExperienceList.length; i++) {
      listings.add(Expanded(
        child: Text(
          patientExperienceList[i].communicationWithNursesPerformanceRate,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
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

  List<Widget> getDoctorCommunication() {
    List listings = List<Widget>();
    for (int i = 0; i < patientExperienceList.length; i++) {
      listings.add(Expanded(
        child: Text(
          patientExperienceList[i].communicationWithDoctorsPerformanceRate,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
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

  List<Widget> getStaffMedicineExplain() {
    List listings = List<Widget>();
    for (int i = 0; i < patientExperienceList.length; i++) {
      listings.add(Expanded(
        child: Text(
          patientExperienceList[i].responsivenessOfHospitalStaffPerformanceRate,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
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

  List<Widget> getCleanQuiet() {
    List listings = List<Widget>();
    for (int i = 0; i < patientExperienceList.length; i++) {
      listings.add(Expanded(
        child: Text(
          patientExperienceList[i]
              .cleanlinessAndQuietnessOfHospitalEnvironmentPerformanceRate,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
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

  List<Widget> getAgreeCare() {
    List listings = List<Widget>();
    for (int i = 0; i < patientExperienceList.length; i++) {
      listings.add(Expanded(
        child: Text(
          patientExperienceList[i].careTransitionPerformanceRate,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
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
