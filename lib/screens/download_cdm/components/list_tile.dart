import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_progress/download_file_button_bloc.dart';
import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_progress/download_file_button_event.dart';
import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_progress/download_file_button_state.dart';
import 'package:curativecare/models/download_cdm_model.dart';
import 'package:curativecare/screens/view_cdm/view_cdm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
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
    BuildContext context,
    DownloadCdmModel hospital,
    int index,
    DownloadFileButtonBloc downloadFileButtonBloc,
    String stateName) {
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
        downloadWidget(hospital, index, downloadFileButtonBloc, stateName),
  );
}

Widget downloadWidget(DownloadCdmModel hospital, int index,
    DownloadFileButtonBloc downloadFileButtonBloc, String stateName) {
  return BlocBuilder(
    cubit: downloadFileButtonBloc,
    builder: (BuildContext context, DownloadFileButtonState state) {
      if (state is DownloadButtonStream && index == state.index) {
        return StreamBuilder<FileResponse>(
            stream: state.fileStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                downloadFileButtonBloc.add(DownloadFileButtonError(
                    "Please check your internet connection and try again"));
                return Material(
                    borderRadius: BorderRadius.circular(20.0),
                    child: InkWell(
                      splashColor: Colors.orange,
                      borderRadius: BorderRadius.circular(20.0),
                      onTap: () async {
                        if ((downloadFileButtonBloc.state
                                is InitialDownloadFileButtonState) ||
                            (downloadFileButtonBloc.state
                                is DownloadButtonErrorState) ||
                            (downloadFileButtonBloc.state
                                is DownloadButtonLoaded)) {
                          downloadFileButtonBloc.add(DownloadFileButtonClick(
                              index,
                              hospital.hospitalName,
                              stateName,
                              downloadFileButtonBloc));
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Please wait',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.green,
                          ));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.file_download,
                          color: Colors.orange,
                          size: 32,
                        ),
                      ),
                    ));
              } else if (snapshot.connectionState == ConnectionState.active &&
                  snapshot.data is DownloadProgress) {
                double fileSize = state.fileSize;
                DownloadProgress downloaded = (snapshot.data);
                double progress = (downloaded.downloaded / fileSize);
                //showing progress from 60 %
                return progressIndicator(progress * 0.6);
              } else if (snapshot.connectionState == ConnectionState.done) {
                FileInfo fileInfo = snapshot.data as FileInfo;
                downloadFileButtonBloc.add(InsertInDatabase(index, fileInfo,
                    hospital.hospitalName, downloadFileButtonBloc));
                return progressIndicator(0.6);
              } else {
                return CircularProgressIndicator();
              }
            });
      } else if (state is DownloadButtonLoadingProgressIndicator &&
          index == state.index) {
        return progressIndicator(state.progress);
      } else if ((state is DownloadButtonLoaded && index == state.index) ||
          (hospital.isDownload == 1)) {
        return RaisedButton(
          color: Colors.orange,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewCDM(hospital.hospitalName)),
            );
          },
          child: Text(
            'View',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white),
          ),
        );
      }
      return Material(
          borderRadius: BorderRadius.circular(20.0),
          child: InkWell(
            splashColor: Colors.orange,
            borderRadius: BorderRadius.circular(20.0),
            onTap: () async {
              if ((downloadFileButtonBloc.state
                      is InitialDownloadFileButtonState) ||
                  (downloadFileButtonBloc.state is DownloadButtonErrorState) ||
                  (downloadFileButtonBloc.state is DownloadButtonLoaded)) {
                downloadFileButtonBloc.add(DownloadFileButtonClick(
                    index,
                    hospital.hospitalName,
                    stateName,
                    BlocProvider.of<DownloadFileButtonBloc>(context)));
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                    'Please wait',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                ));
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.file_download,
                color: Colors.orange,
                size: 32,
              ),
            ),
          ));
    },
  );
}

Widget progressIndicator(double progress) {
  Color foreground = Colors.red;
  if (progress >= 0.8) {
    foreground = Colors.green;
  } else if (progress >= 0.4) {
    foreground = Colors.orange;
  }
  Color background = foreground.withOpacity(0.2);

  return Stack(
    children: <Widget>[
      SizedBox(
        height: 45.0,
        width: 45.0,
        child: CircularProgressIndicator(
          strokeWidth: 6,
          valueColor: new AlwaysStoppedAnimation<Color>(foreground),
          backgroundColor: background,
          value: progress,
        ),
      ),
      Positioned.fill(
        child: Align(
          alignment: Alignment.center,
          child: Text((progress * 100).toStringAsFixed(0)),
        ),
      )
    ],
  );
}
