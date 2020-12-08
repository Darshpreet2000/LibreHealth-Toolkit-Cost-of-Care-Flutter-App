part of 'compare_hospital_screen_bloc.dart';

abstract class CompareHospitalScreenState extends Equatable {
  const CompareHospitalScreenState();
}

class CompareHospitalScreenInitial extends CompareHospitalScreenState {
  @override
  List<Object> get props => [];
}

class LoadedState extends CompareHospitalScreenInitial {
  final List<List<dynamic>> hospitalsData;
  LoadedState(this.hospitalsData);
  @override
  List<Object> get props => [hospitalsData];
}
