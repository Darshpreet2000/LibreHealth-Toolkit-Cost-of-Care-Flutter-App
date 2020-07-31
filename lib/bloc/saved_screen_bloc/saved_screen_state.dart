import 'package:equatable/equatable.dart';

abstract class SavedScreenState extends Equatable {
  const SavedScreenState();
}

class SavedScreenLoadingState extends SavedScreenState {
  @override
  List<Object> get props => [];
}

class SavedScreenLoadedState extends SavedScreenState {
  List<String> savedHospitals;

  SavedScreenLoadedState(this.savedHospitals);

  @override
  List<Object> get props => [savedHospitals];
}

class SavedScreenErrorState extends SavedScreenState {
  String message;

  SavedScreenErrorState(this.message);

  @override
  List<Object> get props => [message];
}
