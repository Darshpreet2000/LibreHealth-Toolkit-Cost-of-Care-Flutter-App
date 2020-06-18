import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
@immutable
abstract class NearbyHospitalEvent extends Equatable {
  const NearbyHospitalEvent();
}

class FetchHospitals extends NearbyHospitalEvent{
  @override
  List<Object> get props => [];

}

class SaveHospitals extends NearbyHospitalEvent{
  @override
  List<Object> get props => [];

}