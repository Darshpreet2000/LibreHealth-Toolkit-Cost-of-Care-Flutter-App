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
  GeneralInformation generalInformationFirstHospital;
  PatientExperience patientExperienceFirstHospital;
  GeneralInformation generalInformationSecondHospital;
  PatientExperience patientExperienceSecondHospital;

  CompareScreenLoadedState(
      this.generalInformationFirstHospital,
      this.patientExperienceFirstHospital,
      this.generalInformationSecondHospital,
      this.patientExperienceSecondHospital);
  @override
  List<Object> get props => [generalInformationFirstHospital,patientExperienceFirstHospital,generalInformationSecondHospital,patientExperienceSecondHospital];

}
class CompareScreenErrorState extends CompareScreenState {
  String message;

  CompareScreenErrorState(this.message);
  @override
  List<Object> get props => [];
}