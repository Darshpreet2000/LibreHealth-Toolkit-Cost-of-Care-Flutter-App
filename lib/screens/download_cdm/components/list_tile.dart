import 'package:curativecare/bloc/download_cdm_bloc/bloc.dart';
import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_bloc.dart';
import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_event.dart';
import 'package:curativecare/models/download_cdm_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

ListTile makeShimmerListTile() {
  return ListTile(
    title: Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.white,
      child: Container(
        height: 20,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    ),
  );
}

ListTile makeListTile(
    BuildContext context, DownloadCdmModel hospital, int index) {
  return ListTile(
    title: Text(
      hospital.hospitalName,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Source',
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    ),
    trailing:
        conditionalWidget(hospital.isDownload, context, hospital, index),
  );
}

Widget conditionalWidget(
    int condition, BuildContext context, DownloadCdmModel hospital, int index) {
  if (condition == 0) {
    return Material(
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          splashColor: Colors.blue,
          borderRadius: BorderRadius.circular(20.0),
          onTap: () => {
            context
                .bloc<DownloadCdmBloc>()
                .add(DownloadCDMGetCSV('Indiana', hospital, index))
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.file_download,
              color: Colors.indigo,
              size: 32,
            ),
          ),
        ));
  } else if (condition == 1) {
    return CircularProgressIndicator();
  } else if (condition == 2) {
    return RaisedButton(
      color: Colors.indigo,
      onPressed: () {},
      child: Text(
        'View',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
