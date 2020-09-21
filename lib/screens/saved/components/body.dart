import 'package:cost_of_care/bloc/download_cdm_bloc/download_cdm_list/download_cdm_bloc.dart';
import 'package:cost_of_care/bloc/download_cdm_bloc/download_cdm_list/download_cdm_state.dart';
import 'package:cost_of_care/bloc/download_cdm_bloc/download_cdm_progress/bloc.dart';
import 'package:cost_of_care/bloc/refresh_saved_cdm_bloc/refresh_saved_cdm_bloc.dart';
import 'package:cost_of_care/bloc/saved_screen_bloc/saved_screen_bloc.dart';
import 'package:cost_of_care/bloc/saved_screen_bloc/saved_screen_event.dart';
import 'package:cost_of_care/bloc/saved_screen_bloc/saved_screen_state.dart';
import 'package:cost_of_care/models/download_cdm_model.dart';
import 'package:cost_of_care/screens/saved/components/saved_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<DownloadCdmModel> savedHospitals;
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RefreshSavedCdmBloc, RefreshSavedCdmState>(
      listener: (BuildContext context, RefreshSavedCdmState state) {
        if (state is RefreshSavedCdmError) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              state.message,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ));
        } else if (savedHospitals == null) {
          BlocProvider.of<RefreshSavedCdmBloc>(context).add(
              RefreshCDMEventError(
                  "No data found to update, please download a ChargeMaster"));
        } else if (state is RefreshSavedCdmStart && i < savedHospitals.length) {
          BlocProvider.of<DownloadFileButtonBloc>(context).add(
              DownloadFileButtonClick(
                  i,
                  savedHospitals[i].hospitalName,
                  box.get(savedHospitals[i].hospitalName),
                  BlocProvider.of<DownloadFileButtonBloc>(context)));
          i++;
        } else if (state is RefreshSavedCdmCompleted) {
          context.bloc<SavedScreenBloc>().add(LoadSavedData());
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              'All Saved CDMs Updated Successfully',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ));
        }
      },
      child: BlocListener<DownloadFileButtonBloc, DownloadFileButtonState>(
        listener: (BuildContext context, DownloadFileButtonState state) {
          if (state is DownloadButtonLoaded && i < savedHospitals.length ||
              state is InitialDownloadFileButtonState &&
                  i < savedHospitals.length) {
            BlocProvider.of<DownloadFileButtonBloc>(context).add(
                DownloadFileButtonClick(
                    i,
                    savedHospitals[i].hospitalName,
                    box.get(savedHospitals[i].hospitalName),
                    BlocProvider.of<DownloadFileButtonBloc>(context)));
            i++;
          } else if (state is DownloadButtonErrorState) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                state.message,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.deepOrangeAccent,
            ));
            BlocProvider.of<RefreshSavedCdmBloc>(context).add(
                RefreshCDMEventError(
                    "Unable to refresh CDM, please try again"));
          } else if (i == savedHospitals.length &&
              state is DownloadButtonLoaded) {
            i = 0;
            BlocProvider.of<RefreshSavedCdmBloc>(context)
                .add(RefreshCDMEventCompleted());
          }
        },
        child: BlocListener<DownloadCdmBloc, DownloadCdmState>(
          listener: (BuildContext context, DownloadCdmState state) {
            if (state is LoadedState) {
              context.bloc<SavedScreenBloc>().add(LoadSavedData());
            } else if (state is ErrorState) {
              context.bloc<SavedScreenBloc>().add(ShowNoDataFound());
            }
          },
          child: BlocBuilder<SavedScreenBloc, SavedScreenState>(
            builder: (BuildContext context, SavedScreenState state) {
              if (state is SavedScreenLoadedState) {
                savedHospitals = state.savedHospitals;
                return SavedList(state.savedHospitals);
              } else if (state is SavedScreenLoadingState) {
                return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is SavedScreenErrorState) {
                return Container(
                    child: Center(
                  child: Text(
                    state.message,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ));
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
