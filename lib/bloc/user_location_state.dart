import 'package:curativecare/models/location.dart';
import 'package:equatable/equatable.dart';

abstract class LocationState extends Equatable {
  const LocationState();
}


class LocationLoading extends LocationState {
  const LocationLoading();
  @override
  List<Object> get props => [];
}

class LocationLoaded extends LocationState {
  final Location current;
  const LocationLoaded(this.current);
  @override
  List<Object> get props => [current];
}

class LocationError extends LocationState {
  final String message;
  const LocationError(this.message);
  @override
  List<Object> get props => [message];
}