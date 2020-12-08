part of 'compare_hospital_list_bloc.dart';

abstract class CompareHospitalListState extends Equatable {
  const CompareHospitalListState();
}

class LoadingState extends CompareHospitalListState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ErrorState extends CompareHospitalListState {
  final String message;
  @override
  // TODO: implement props
  List<Object> get props => [message];

  ErrorState(this.message);
}

class ShowSnackBar extends CompareHospitalListState {
  final String message;
  ShowSnackBar(this.message);
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadedState extends CompareHospitalListState {
  final List<List<dynamic>> hospitalCompareData;

  LoadedState(this.hospitalCompareData);

  @override
  List<Object> get props => [hospitalCompareData];
}
