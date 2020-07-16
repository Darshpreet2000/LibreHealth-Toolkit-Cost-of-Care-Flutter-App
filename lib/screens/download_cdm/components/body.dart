import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_list/bloc.dart';
import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_progress/bloc.dart';
import 'package:curativecare/bloc/location_bloc/location_bloc.dart';
import 'package:curativecare/bloc/location_bloc/user_location_state.dart';
import 'package:curativecare/bloc/nearby_hospital_bloc/bloc.dart';
import 'package:curativecare/models/download_cdm_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';
import 'list_tile.dart';

class Body extends StatelessWidget {
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
              },
              child:
                  BlocListener<DownloadFileButtonBloc, DownloadFileButtonState>(
                listener:
                    (BuildContext context, DownloadFileButtonState state) {
                  if (state is DownloadButtonLoaded) {
                    context
                        .bloc<DownloadCdmBloc>()
                        .add(DownloadCDMRefreshList(state.index));
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
                      return ShowList(state.hospitalsName);
                    } else if (state is RefreshedState) {
                      return ShowList(state.hospitalsName);
                    } else if (state is ErrorState) {
                      return Center(
                        child: Container(
                          child: Text(state.message),
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
    itemCount: 6,
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

class ShowList extends StatefulWidget {
  List<DownloadCdmModel> hospitalsName;

  ShowList(this.hospitalsName);

  @override
  _ShowListState createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  @override
  Widget build(BuildContext context) {
    DownloadFileButtonBloc downloadFileButtonBloc =
        BlocProvider.of<DownloadFileButtonBloc>(context);
    return Scrollbar(
      child: ListView.builder(
        itemCount: widget.hospitalsName.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 4.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.grey[50]),
              child: makeListTile(context, widget.hospitalsName[index], index,
                  downloadFileButtonBloc),
            ),
          );
        },
      ),
    );
  }
}
