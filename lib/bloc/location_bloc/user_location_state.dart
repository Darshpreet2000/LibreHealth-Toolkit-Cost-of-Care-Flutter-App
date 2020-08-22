import 'package:equatable/equatable.dart';

abstract class LocationState extends Equatable {
  const LocationState();
}

class LocationLoading extends LocationState {
  @override
  List<Object> get props => [];
}

class LocationLoaded extends LocationState {
  final String address;

  LocationLoaded(this.address);

  @override
  List<Object> get props => [address];
}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);

  @override
  List<Object> get props => [message];
}
