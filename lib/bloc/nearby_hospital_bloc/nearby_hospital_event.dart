import 'package:curativecare/models/hospitals.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class NearbyHospitalEvent extends Equatable {
  const NearbyHospitalEvent();
}

class FetchHospitals extends NearbyHospitalEvent {
  final String state;

  FetchHospitals(this.state);

  @override
  List<Object> get props => [state];
}

class FetchImages extends NearbyHospitalEvent {
  final List<Hospitals> list;

  FetchImages(this.list);

  @override
  List<Object> get props => [];
}

class SaveHospitals extends NearbyHospitalEvent {
  @override
  List<Object> get props => [];
}

class NearbyHospitalShowError extends NearbyHospitalEvent {
  final String message;

  NearbyHospitalShowError(this.message);

  @override
  List<Object> get props => [message];
}
