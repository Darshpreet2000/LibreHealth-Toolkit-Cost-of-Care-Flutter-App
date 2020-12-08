part of 'compare_hospital_screen_bloc.dart';

abstract class CompareHospitalScreenEvent extends Equatable {
  const CompareHospitalScreenEvent();
}

class AddHospitals extends CompareHospitalScreenEvent {
  final List<List<dynamic>> hospitalToCompare;

  AddHospitals(this.hospitalToCompare);
  @override
  List<Object> get props => [hospitalToCompare];
}
