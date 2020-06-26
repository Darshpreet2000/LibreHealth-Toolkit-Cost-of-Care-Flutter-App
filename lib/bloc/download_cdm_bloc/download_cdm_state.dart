import 'package:curativecare/models/download_cdm_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class DownloadCdmState extends Equatable {
  const DownloadCdmState();
}

class LoadingState extends DownloadCdmState {
  @override
  List<Object> get props => [];
}

class LoadedState extends DownloadCdmState {
  final List<DownloadCdmModel> hospitalsName;

  LoadedState(this.hospitalsName);
  @override
  List<Object> get props => [hospitalsName];
}

class RefreshedState extends DownloadCdmState {
  final List<DownloadCdmModel> hospitalsName;


  RefreshedState(this.hospitalsName);

  @override
  List<Object> get props => [hospitalsName];
}

class ErrorStateSnackbar extends DownloadCdmState {
  @override
  List<Object> get props => [];
}


class ErrorState extends DownloadCdmState {
  @override
  List<Object> get props => [];
}
