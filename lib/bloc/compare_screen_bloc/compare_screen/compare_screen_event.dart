import 'package:curativecare/models/compare_hospital_model.dart';
import 'package:equatable/equatable.dart';

abstract class CompareScreenEvent extends Equatable {
  const CompareScreenEvent();
}

class CompareScreenFetchData extends CompareScreenEvent {
  final List<CompareHospitalModel> hospitalNames;

  CompareScreenFetchData(this.hospitalNames);

  @override
  List<Object> get props => [hospitalNames];
}
