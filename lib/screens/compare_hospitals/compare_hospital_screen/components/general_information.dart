import 'package:curativecare/models/general_information.dart';
import 'package:curativecare/widgets/star_widget.dart';
import 'package:flutter/material.dart';

class GeneralInformationWidget extends StatelessWidget {
  final List<GeneralInformation> generalInformationList;

  GeneralInformationWidget(this.generalInformationList);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "General Information",
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.black,
        size: 30,
      ),
      children: <Widget>[
        Text(
          "Overall Rating",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        IntrinsicHeight(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: getOverAllRating()),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "Hospital Type",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        IntrinsicHeight(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: getHospitalType()),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "Provides emergency services",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        IntrinsicHeight(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: getProvidesEmergency()),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "Phone Number",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        IntrinsicHeight(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: getPhoneNumber()),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "Ownership Type",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        IntrinsicHeight(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: getOwnership()),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }

  List<Widget> getOverAllRating() {
    List listings = List<Widget>();
    for (int i = 0; i < generalInformationList.length; i++) {
      listings.add(Expanded(
        child: Center(
          child: IconTheme(
              data: IconThemeData(
                color: Colors.amber,
                size: 30,
              ),
              child: StarDisplay(
                  value: (generalInformationList[i].hospitalOverallRating))),
        ),
      ));

      if (i != generalInformationList.length - 1)
        listings.add(VerticalDivider(
          thickness: 2,
          width: 20,
          color: Colors.grey[400],
        ));
    }
    return listings;
  }

  List<Widget> getHospitalType() {
    List listings = List<Widget>();
    for (int i = 0; i < generalInformationList.length; i++) {
      listings.add(Expanded(
        child: Text(
          generalInformationList[i].hospitalType,
          style: TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
        ),
      ));

      if (i != generalInformationList.length - 1)
        listings.add(VerticalDivider(
          thickness: 2,
          width: 20,
          color: Colors.grey[400],
        ));
    }
    return listings;
  }

  List<Widget> getProvidesEmergency() {
    List listings = List<Widget>();
    for (int i = 0; i < generalInformationList.length; i++) {
      listings.add(Expanded(
        child: Text(
          generalInformationList[i].emergencyServices,
          style: TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
        ),
      ));

      if (i != generalInformationList.length - 1)
        listings.add(VerticalDivider(
          thickness: 2,
          width: 20,
          color: Colors.grey[400],
        ));
    }
    return listings;
  }

  List<Widget> getPhoneNumber() {
    List listings = List<Widget>();
    for (int i = 0; i < generalInformationList.length; i++) {
      listings.add(Expanded(
        child: Text(
          generalInformationList[i].phoneNumber,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
        ),
      ));

      if (i != generalInformationList.length - 1)
        listings.add(VerticalDivider(
          thickness: 2,
          width: 20,
          color: Colors.grey[400],
        ));
    }
    return listings;
  }

  List<Widget> getOwnership() {
    List listings = List<Widget>();
    for (int i = 0; i < generalInformationList.length; i++) {
      listings.add(Expanded(
        child: Text(
          generalInformationList[i].hospitalOwnership,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
        ),
      ));
      if (i != generalInformationList.length - 1)
        listings.add(VerticalDivider(
          thickness: 2,
          width: 20,
          color: Colors.grey[400],
        ));
    }
    return listings;
  }
}
