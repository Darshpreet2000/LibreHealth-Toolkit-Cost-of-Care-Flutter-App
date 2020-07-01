import 'package:curativecare/models/hospitals.dart';
import 'package:equatable/equatable.dart';

abstract class NearbyHospitalState extends Equatable {
  const NearbyHospitalState();
}

class NearbyHospitalsLoadingState extends NearbyHospitalState {
  @override
  List<Object> get props => [];
}

class NearbyHospitalsLoadedState extends NearbyHospitalState {
  List<Hospitals> nearby_hospital;

  NearbyHospitalsLoadedState(this.nearby_hospital);

  @override
  List<Object> get props => [nearby_hospital];
}

class NearbyHospitalsErrorState extends NearbyHospitalState {
  String message;

  NearbyHospitalsErrorState(this.message);

  @override
  List<Object> get props => [];
}
