import 'package:curativecare/models/hospitals.dart';
import 'package:equatable/equatable.dart';

abstract class NearbyHospitalState extends Equatable {
  const NearbyHospitalState();
}

class LoadingState extends NearbyHospitalState {
  @override
  List<Object> get props => [];
}

class LoadedState extends NearbyHospitalState {
  List<Hospitals> nearby_hospital;

  LoadedState(this.nearby_hospital);

  @override
  List<Object> get props => [];
}

class ErrorState extends NearbyHospitalState {
  String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [];
}
