import 'package:curativecare/models/nearby_hospital.dart';
import 'package:equatable/equatable.dart';

abstract class NearbyHospitalState extends Equatable {
  const NearbyHospitalState();
}

class LoadingState extends NearbyHospitalState {
  @override
  List<Object> get props => [];
}

class LoadedState extends NearbyHospitalState {
  List<NearbyHospital> nearby_hospital;

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
