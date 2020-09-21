import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class LocationEvent extends Equatable {
  const LocationEvent();
}

class FetchLocation extends LocationEvent {
  FetchLocation();

  @override
  String toString() => 'LoadTodos';

  @override
  List<Object> get props => [];
}

class RefreshLocation extends LocationEvent {
  RefreshLocation();

  @override
  String toString() => 'UpdateTodo { updatedTodo: }';

  @override
  List<Object> get props => [];
}

class ChangeLocationAndSettings extends LocationEvent {
  @override
  List<Object> get props => [];

  ChangeLocationAndSettings();
}
