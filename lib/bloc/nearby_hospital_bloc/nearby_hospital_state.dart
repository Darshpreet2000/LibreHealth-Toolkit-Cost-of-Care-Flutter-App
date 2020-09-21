import 'package:cost_of_care/models/hospitals.dart';
import 'package:equatable/equatable.dart';

abstract class NearbyHospitalState extends Equatable {
  const NearbyHospitalState();
}

class NearbyHospitalsLoadingState extends NearbyHospitalState {
  @override
  List<Object> get props => [];
}

class NearbyHospitalsLoadedState extends NearbyHospitalState {
  final List<Hospitals> nearbyHospital;

  NearbyHospitalsLoadedState(this.nearbyHospital);

  @override
  List<Object> get props => [nearbyHospital];
}

class NearbyHospitalsErrorState extends NearbyHospitalState {
  final String message;

  NearbyHospitalsErrorState(this.message);

  @override
  List<Object> get props => [];
}
