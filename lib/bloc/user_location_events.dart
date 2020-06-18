import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class LocationEvent extends Equatable {
const LocationEvent();
}


class FetchLocation extends LocationEvent {
  @override
  String toString() => 'LoadTodos';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}


class RefreshLocation extends LocationEvent {

  @override
  String toString() => 'UpdateTodo { updatedTodo: }';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
