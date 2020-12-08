import 'package:cached_network_image/cached_network_image.dart';
import 'package:cost_of_care/bloc/compare_hospital_bloc/compare_hospital_screen/compare_hospital_screen_bloc.dart';
import 'package:cost_of_care/repository/compare_screen_repository_impl.dart';
import 'package:cost_of_care/screens/compare_hospitals/compare_hospital_screen/components/patient_survey.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import 'general_information.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CompareScreenRepositoryImpl compareScreenRepositoryImpl =
      new CompareScreenRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompareHospitalScreenBloc, CompareHospitalScreenState>(
        builder: (BuildContext context, CompareHospitalScreenState state) {
      if (state is LoadedState) {
        return SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(8),
              child: Column(children: <Widget>[
                Row(children: getListOfWidgets(state.hospitalsData)),
                SizedBox(
                  height: 8,
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: getHospitalImages(state.hospitalsData),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                GeneralInformationWidget(state.hospitalsData),
                PatientSurveyWidget(state.hospitalsData),
              ])),
        );
      }
      return Center(
          child: Container(
        child: CircularProgressIndicator(),
      ));
    });
  }

  List<Widget> getListOfWidgets(List<List<dynamic>> hospitalsName) {
    List<Widget> listings = new List();
    for (int i = 0; i < 2; i++) {
      listings.add(Expanded(
        child: Text(
          hospitalsName[i][0],
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
        ),
      ));

      listings.add(VerticalDivider(
        thickness: 2,
        width: 20,
        color: Colors.grey[400],
      ));
    }
    return listings;
  }

  List<Widget> getHospitalImages(List<List<dynamic>> hospitalsName) {
    List listings = List<Widget>();
    for (int i = 0; i < 2; i++) {
      listings.add(
        Expanded(
          child: FutureBuilder(
            future:
                compareScreenRepositoryImpl.fetchImages(hospitalsName[i][0]),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: new FittedBox(
                      fit: BoxFit.fill,
                      child: Image.asset('assets/placeholder.png')),
                );
              }
              if (snapshot.hasData) {
                return CachedNetworkImage(
                  imageUrl: snapshot.data,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(),
                      )),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                );
              }
              return Container(
                height: 120,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              );
            },
          ),
        ),
      );
      if (i != hospitalsName.length - 1)
        listings.add(VerticalDivider(
          thickness: 2,
          width: 20,
          color: Colors.grey[400],
        ));
    }
    return listings;
  }
}
