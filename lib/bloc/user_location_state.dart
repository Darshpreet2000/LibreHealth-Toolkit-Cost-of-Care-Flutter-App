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
  final String address;
  const LocationLoaded(this.address);
  @override
  List<Object> get props => [address];
}

class LocationError extends LocationState {
  final String message;
  const LocationError(this.message);
  @override
  List<Object> get props => [message];
}