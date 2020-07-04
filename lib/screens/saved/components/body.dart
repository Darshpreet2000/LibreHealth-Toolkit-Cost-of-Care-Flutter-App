import 'package:curativecare/bloc/download_cdm_bloc/bloc.dart';
import 'package:curativecare/bloc/saved_screen_bloc/saved_screen_bloc.dart';
import 'package:curativecare/bloc/saved_screen_bloc/saved_screen_event.dart';
import 'package:curativecare/bloc/saved_screen_bloc/saved_screen_state.dart';
import 'package:curativecare/screens/saved/components/saved_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<DownloadCdmBloc, DownloadCdmState>(
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
            return SavedList(state.savedHospitals);
          } else if (state is SavedScreenLoadingState) {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (state is SavedScreenErrorState) {
            return Container(
              child: Center(child: Text(state.message)),
            );
          }
        },
      ),
    );
  }
}
