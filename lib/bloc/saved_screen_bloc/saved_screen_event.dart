import 'package:equatable/equatable.dart';

abstract class SavedScreenEvent extends Equatable {
  const SavedScreenEvent();
}

class LoadSavedData extends SavedScreenEvent {
  @override
  List<Object> get props => [];
}

class ShowNoDataFound extends SavedScreenEvent {
  @override
  List<Object> get props => [];
}
