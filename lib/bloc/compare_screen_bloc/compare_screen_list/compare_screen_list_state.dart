import 'package:curativecare/models/compare_hospital_model.dart';
import 'package:equatable/equatable.dart';

abstract class CompareScreenListState extends Equatable {
  const CompareScreenListState();
}

class CompareScreenListLoadingState extends CompareScreenListState {
  @override
  List<Object> get props => [];
}

class CompareScreenListLoadedState extends CompareScreenListState {
  final List<CompareHospitalModel> hospitalName;

  CompareScreenListLoadedState(this.hospitalName);

  @override
  List<Object> get props => [hospitalName];
}

class CompareScreenListErrorState extends CompareScreenListState {
  final String message;
  CompareScreenListErrorState(this.message);

  @override
  List<Object> get props => [message];
}
