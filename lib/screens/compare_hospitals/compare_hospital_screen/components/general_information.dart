import 'package:curativecare/models/general_information.dart';
import 'package:curativecare/widgets/star_widget.dart';
import 'package:flutter/material.dart';

class GeneralInformationWidget extends StatelessWidget {
  GeneralInformation generalInformationFirstHospital;
  GeneralInformation generalInformationSecondHospital;

  GeneralInformationWidget(this.generalInformationFirstHospital,
      this.generalInformationSecondHospital);

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
            children: <Widget>[
              Expanded(
                child: Center(
                  child: IconTheme(
                    data: IconThemeData(
                      color: Colors.amber,
                      size: 30,
                    ),
                    child: StarDisplay(
                            value:(generalInformationFirstHospital
                                .hospitalOverallRating))
                  ),
                ),
              ),
              VerticalDivider(
                thickness: 2,
                width: 20,
                color: Colors.grey[400],
              ),
              Expanded(
                child: Center(
                  child: IconTheme(
                    data: IconThemeData(
                      color: Colors.amber,
                      size: 30,
                    ),
                    child:StarDisplay(
                            value: generalInformationSecondHospital
                                .hospitalOverallRating)
                  ),
                ),
              )
            ],
          ),
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
            children: <Widget>[
              Expanded(
                child: Text(
                  generalInformationFirstHospital.hospitalType,
                  style: TextStyle(
                    fontSize: 18,
                  ),
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
                  generalInformationSecondHospital.hospitalType,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
              )
            ],
          ),
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
            children: <Widget>[
              Expanded(
                child: Text(
                  generalInformationFirstHospital.emergencyServices,
                  style: TextStyle(
                    fontSize: 18,
                  ),
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
                  generalInformationSecondHospital.emergencyServices,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
              )
            ],
          ),
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
            children: <Widget>[
              Expanded(
                child: Text(
                  generalInformationFirstHospital.phoneNumber,
                  style: TextStyle(
                    fontSize: 18,
                  ),
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
                  generalInformationSecondHospital.phoneNumber,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
              )
            ],
          ),
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
            children: <Widget>[
              Expanded(
                child: Text(
                  generalInformationFirstHospital.hospitalOwnership,
                  style: TextStyle(
                    fontSize: 18,
                  ),
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
                  generalInformationSecondHospital.hospitalOwnership,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
