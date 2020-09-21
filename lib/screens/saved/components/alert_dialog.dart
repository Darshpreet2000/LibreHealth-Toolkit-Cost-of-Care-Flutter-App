import 'package:cost_of_care/bloc/download_cdm_bloc/download_cdm_progress/bloc.dart';
import 'package:cost_of_care/bloc/refresh_saved_cdm_bloc/refresh_saved_cdm_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future showRefreshDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Attention!',
            textAlign: TextAlign.center,
          ),
          content: Container(
              width: double.maxFinite,
              child: Text(
                  'You are going refresh all your downloaded ChargeMasters. Click on Allow to proceed')),
          actions: [
            FlatButton(
              child: Text("Deny"),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
            ),
            FlatButton(
              child: Text("Allow"),
              onPressed: () {
                if (BlocProvider.of<DownloadFileButtonBloc>(context).state
                        is DownloadButtonLoaded ||
                    BlocProvider.of<DownloadFileButtonBloc>(context).state
                        is InitialDownloadFileButtonState)
                  BlocProvider.of<RefreshSavedCdmBloc>(context)
                      .add(RefreshCDMEventStart());
                else
                  BlocProvider.of<RefreshSavedCdmBloc>(context)
                      .add(RefreshCDMEventError("Please wait"));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

Future showDeleteAllDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Attention!',
            textAlign: TextAlign.center,
          ),
          content: Container(
              width: double.maxFinite,
              child: Text(
                  'You are going to delete all your downloaded ChargeMasters. Click on Allow to proceed')),
          actions: [
            FlatButton(
              child: Text("Deny"),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
            ),
            FlatButton(
              child: Text("Allow"),
              onPressed: () {
                if (BlocProvider.of<DownloadFileButtonBloc>(context).state
                        is DownloadButtonLoaded ||
                    BlocProvider.of<DownloadFileButtonBloc>(context).state
                        is InitialDownloadFileButtonState)
                  BlocProvider.of<RefreshSavedCdmBloc>(context)
                      .add(RefreshCDMEventStart());
                else
                  BlocProvider.of<RefreshSavedCdmBloc>(context)
                      .add(RefreshCDMEventError("Please wait"));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
