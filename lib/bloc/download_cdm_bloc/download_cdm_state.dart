import 'package:equatable/equatable.dart';

abstract class DownloadCdmState extends Equatable {
  const DownloadCdmState();
}

class LoadingState extends DownloadCdmState {
  @override
  List<Object> get props => [];
}

class LoadedState extends DownloadCdmState {
  List<String> hospitalsName;

  LoadedState(this.hospitalsName);

  @override
  List<Object> get props => [];
}

class ErrorState extends DownloadCdmState{
  @override
  List<Object> get props => [];

}