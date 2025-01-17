import 'package:cost_of_care/models/download_cdm_model.dart';
import 'package:equatable/equatable.dart';

abstract class SavedScreenState extends Equatable {
  const SavedScreenState();
}

class SavedScreenLoadingState extends SavedScreenState {
  @override
  List<Object> get props => [];
}

class SavedScreenLoadedState extends SavedScreenState {
  final List<DownloadCdmModel> savedHospitals;

  SavedScreenLoadedState(this.savedHospitals);

  @override
  List<Object> get props => [savedHospitals];
}

class SavedScreenErrorState extends SavedScreenState {
  final String message;

  SavedScreenErrorState(this.message);

  @override
  List<Object> get props => [message];
}
