import 'package:cost_of_care/widgets/star_widget.dart';
import 'package:flutter/material.dart';

class GeneralInformationWidget extends StatelessWidget {
  final List<List<dynamic>> generalInformationList;

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
                  value: (generalInformationList[i][7].toString()))),
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
          generalInformationList[i][4],
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
          generalInformationList[i][6],
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
          generalInformationList[i][3],
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

  List<Widget> getOwnership() {
    List listings = List<Widget>();
    for (int i = 0; i < generalInformationList.length; i++) {
      listings.add(Expanded(
        child: Text(
          generalInformationList[i][5],
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
}
