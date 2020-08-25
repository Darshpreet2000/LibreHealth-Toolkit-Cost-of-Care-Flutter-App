import 'package:cost_of_care/bloc/download_cdm_bloc/download_cdm_progress/download_file_button_bloc.dart';
import 'package:cost_of_care/bloc/download_cdm_bloc/download_cdm_progress/download_file_button_event.dart';
import 'package:cost_of_care/bloc/download_cdm_bloc/download_cdm_progress/download_file_button_state.dart';
import 'package:cost_of_care/models/download_cdm_model.dart';
import 'package:cost_of_care/screens/view_cdm/view_cdm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../main.dart';

class SavedList extends StatefulWidget {
  final List<DownloadCdmModel> hospitalNames;

  SavedList(this.hospitalNames);

  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return ShowList(widget.hospitalNames, box.get('state'),
        BlocProvider.of<DownloadFileButtonBloc>(context));
  }
}

class ShowList extends StatelessWidget {
  final List<DownloadCdmModel> hospitalsName;

  final String stateName;
  final DownloadFileButtonBloc downloadFileButtonBloc;

  ShowList(this.hospitalsName, this.stateName, this.downloadFileButtonBloc);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: hospitalsName.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 4.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.grey[50]),
              child: makeListTile(context, hospitalsName[index], index,
                  downloadFileButtonBloc, stateName),
            ),
          );
        },
      ),
    );
  }
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
      if (state is DownloadButtonLoadingCircular && index == state.index) {
        return CircularProgressIndicator();
      } else if (state is DownloadButtonStream && index == state.index) {
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
