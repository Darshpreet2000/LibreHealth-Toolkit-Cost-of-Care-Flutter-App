import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_list/bloc.dart';
import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_progress/bloc.dart';
import 'package:curativecare/bloc/location_bloc/location_bloc.dart';
import 'package:curativecare/bloc/location_bloc/user_location_state.dart';
import 'package:curativecare/bloc/saved_screen_bloc/bloc.dart';
import 'package:curativecare/models/download_cdm_model.dart';
import 'package:curativecare/repository/download_cdm_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';
import 'list_tile.dart';

class Body extends StatefulWidget {
  final String stateName;
  Body(this.stateName);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DownloadFileButtonBloc downloadFileButtonBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocListener<LocationBloc, LocationState>(
            listener: (BuildContext context, state) async {
              if (state is LocationLoaded) {
                String state = await box.get('state');
                BlocProvider.of<DownloadCdmBloc>(context)
                    .add(DownloadCDMFetchData(state));
                downloadFileButtonBloc =
                    new DownloadFileButtonBloc(DownloadCDMRepositoryImpl());
              } else if (state is LocationError) {
                BlocProvider.of<DownloadCdmBloc>(context)
                    .add(DownloadCDMError(state.message));
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
                } else if (state is ErrorState) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                      state.message,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.deepOrangeAccent,
                  ));
                }
              },
              child: BlocListener(
                cubit: downloadFileButtonBloc,
                listener:
                    (BuildContext context, DownloadFileButtonState state) {
                  if (state is DownloadButtonLoaded) {
                    BlocProvider.of<DownloadCdmBloc>(context).add(
                        DownloadCDMRefreshList(state.index, widget.stateName));
                    context.bloc<SavedScreenBloc>().add(LoadSavedData());
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
                      return shimmerLoading();
                    else if (state is LoadedState) {
                      return ShowList(state.hospitalsName, widget.stateName,
                          downloadFileButtonBloc);
                    } else if (state is RefreshedState) {
                      return ShowList(state.hospitalsName, widget.stateName,
                          downloadFileButtonBloc);
                    } else if (state is ErrorState) {
                      return Center(
                        child: Container(
                          child: Text(
                            state.message,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            )));
  }

  @override
  void dispose() {
    super.dispose();
    downloadFileButtonBloc.close();
  }
}

Widget shimmerLoading() {
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
