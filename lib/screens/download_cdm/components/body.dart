import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_list/bloc.dart';
import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_progress/bloc.dart';
import 'package:curativecare/bloc/location_bloc/location_bloc.dart';
import 'package:curativecare/bloc/location_bloc/user_location_state.dart';
import 'package:curativecare/bloc/nearby_hospital_bloc/bloc.dart';
import 'package:curativecare/bloc/saved_screen_bloc/bloc.dart';
import 'package:curativecare/models/download_cdm_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';
import 'list_tile.dart';

class Body extends StatelessWidget {
  String stateName;

  Body([this.stateName]);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocListener<LocationBloc, LocationState>(
            listener: (BuildContext context, state) async {
              if (state is LocationLoaded) {
                String state = await box.get('state');
                context
                    .bloc<DownloadCdmBloc>()
                    .add(DownloadCDMFetchData(state));
              }
              if (state is NearbyHospitalsLoadedState) {
              } else if (state is LocationError) {
                context.bloc<DownloadCdmBloc>().add(DownloadCDMError());
              }
            },
            child: BlocListener<DownloadCdmBloc, DownloadCdmState>(
              listener: (BuildContext context, DownloadCdmState state) {
                if (state is ErrorStateSnackbar) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Network Error',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.deepOrangeAccent,
                  ));
                }
                else if(state is ErrorState){
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                      state.message,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.deepOrangeAccent,
                  ));
                }
              },
              child:
                  BlocListener<DownloadFileButtonBloc, DownloadFileButtonState>(
                listener:
                    (BuildContext context, DownloadFileButtonState state) {
                  if (state is DownloadButtonLoaded) {
                    if(stateName==null) {
                       stateName = box.get('state');
                    }
                    context
                        .bloc<DownloadCdmBloc>()
                        .add(DownloadCDMRefreshList(state.index,stateName));
                  } else if (state is DownloadButtonErrorState) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                        state.message,
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.deepOrangeAccent,
                    ));
                  }
                },
                child: BlocBuilder<DownloadCdmBloc, DownloadCdmState>(
                  builder: (BuildContext context, DownloadCdmState state) {
                    if (state is LoadingState)
                      return ShimmerLoading();
                    else if (state is LoadedState) {
                      if(stateName==null)
                        stateName=box.get('state');
                      return ShowList(state.hospitalsName,stateName);
                    } else if (state is RefreshedState) {
                        if(stateName==null)
                        stateName=box.get('state');
                      return ShowList(state.hospitalsName,stateName);
                    } else if (state is ErrorState) {
                      return Center(
                        child: Container(
                          child: Text(state.message,style: TextStyle(fontSize: 18),
                        ),
                        ),
                      );
                    }
                  },
                ),
              ),
            )));
  }
}

Widget ShimmerLoading() {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: 10,
    itemBuilder: (BuildContext context, int index) {
      return Card(
        elevation: 4.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.grey[50]),
          child: makeShimmerListTile(),
        ),
      );
    },
  );
}

class ShowList extends StatelessWidget {
  List<DownloadCdmModel> hospitalsName;
  String stateName;
  ShowList(this.hospitalsName, this.stateName);

  @override
  Widget build(BuildContext context) {
    DownloadFileButtonBloc downloadFileButtonBloc =
        BlocProvider.of<DownloadFileButtonBloc>(context);
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
                  downloadFileButtonBloc,stateName),
            ),
          );
        },
      ),
    );
  }
}
