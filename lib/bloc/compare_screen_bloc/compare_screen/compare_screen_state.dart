import 'package:curativecare/models/general_information.dart';
import 'package:curativecare/models/patient_experience.dart';
import 'package:equatable/equatable.dart';

abstract class CompareScreenState extends Equatable {
  const CompareScreenState();
}

class CompareScreenLoadingState extends CompareScreenState {
  @override
  List<Object> get props => [];
}

class CompareScreenLoadedState extends CompareScreenState {
  final List<GeneralInformation> generalInformation;
  final List<PatientExperience> patientExperience;

  CompareScreenLoadedState(this.generalInformation, this.patientExperience);

  @override
  List<Object> get props => [generalInformation, patientExperience];
}

class CompareScreenErrorState extends CompareScreenState {
  final String message;

  CompareScreenErrorState(this.message);
  @override
  List<Object> get props => [];
}
