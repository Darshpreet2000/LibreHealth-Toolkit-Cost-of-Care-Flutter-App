import 'package:cached_network_image/cached_network_image.dart';
import 'package:curativecare/bloc/compare_screen_bloc/compare_screen/bloc.dart';
import 'package:curativecare/bloc/compare_screen_bloc/compare_screen/compare_screen_bloc.dart';
import 'package:curativecare/bloc/compare_screen_bloc/compare_screen/compare_screen_state.dart';
import 'package:curativecare/models/compare_hospital_model.dart';
import 'package:curativecare/repository/compare_screen_repository_impl.dart';
import 'package:curativecare/screens/compare_hospitals/compare_hospital_screen/components/general_information.dart';
import 'package:curativecare/screens/compare_hospitals/compare_hospital_screen/components/patient_survey.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class Body extends StatefulWidget {
  final List<CompareHospitalModel> hospitalNamesForCompare;

  Body(this.hospitalNamesForCompare);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CompareScreenRepositoryImpl compareScreenRepositoryImpl =
      new CompareScreenRepositoryImpl();
  @override
  void initState() {
    super.initState();
    context
        .bloc<CompareScreenBloc>()
        .add(CompareScreenFetchData(widget.hospitalNamesForCompare));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(8),
          child: Column(children: <Widget>[
            Row(children: getListOfWidgets()),
            SizedBox(
              height: 8,
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: getHospitalImages(),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            BlocBuilder<CompareScreenBloc, CompareScreenState>(
                builder: (BuildContext context, CompareScreenState state) {
              if (state is CompareScreenLoadedState) {
                return Column(
                  children: <Widget>[
                    GeneralInformationWidget(state.generalInformation),
                    PatientSurveyWidget(state.patientExperience)
                  ],
                );
              } else if (state is CompareScreenLoadingState) {
                return Container(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is CompareScreenErrorState) {
                return Container(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      state.message,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              }

              return Container();
            })
          ])),
    );
  }

  List<Widget> getListOfWidgets() {
    List listings = List<Widget>();
    for (int i = 0; i < widget.hospitalNamesForCompare.length; i++) {
      listings.add(Expanded(
        child: Text(
          widget.hospitalNamesForCompare[i].hospitalName,
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

  List<Widget> getHospitalImages() {
    List listings = List<Widget>();
    for (int i = 0; i < widget.hospitalNamesForCompare.length; i++) {
      listings.add(
        Expanded(
          child: FutureBuilder(
            future: compareScreenRepositoryImpl
                .fetchImages(widget.hospitalNamesForCompare[i].hospitalName),
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
      if (i != widget.hospitalNamesForCompare.length - 1)
        listings.add(VerticalDivider(
          thickness: 2,
          width: 20,
          color: Colors.grey[400],
        ));
    }
    return listings;
  }
}
