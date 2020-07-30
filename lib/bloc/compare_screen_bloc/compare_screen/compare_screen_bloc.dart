import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:curativecare/models/general_information.dart';
import 'package:curativecare/models/patient_experience.dart';
import 'package:curativecare/repository/compare_screen_repository_impl.dart';
import './bloc.dart';

class CompareScreenBloc extends Bloc<CompareScreenEvent, CompareScreenState> {
  CompareScreenRepositoryImpl compareScreenRepositoryImpl;

  CompareScreenBloc(this.compareScreenRepositoryImpl)
      : super(CompareScreenLoadingState());

  @override
  Stream<CompareScreenState> mapEventToState(
    CompareScreenEvent event,
  ) async* {
    if (event is CompareScreenFetchData) {
    try {
      GeneralInformation generalInformationFirstHospital =
      await compareScreenRepositoryImpl
          .fetchGeneralInformation(event.hospitalNameFirst);
      PatientExperience patientExperienceFirstHospital =
      await compareScreenRepositoryImpl
          .fetchPatientExperience(event.hospitalNameFirst);
      GeneralInformation generalInformationSecondHospital =
      await compareScreenRepositoryImpl
          .fetchGeneralInformation(event.hospitalNameSecond);
      PatientExperience patientExperienceSecondHospital =
      await compareScreenRepositoryImpl
          .fetchPatientExperience(event.hospitalNameSecond);
      yield CompareScreenLoadedState(
          generalInformationFirstHospital, patientExperienceFirstHospital,
          generalInformationSecondHospital, patientExperienceSecondHospital);
    }
    catch(e){
      yield CompareScreenErrorState(e.message);
    }
    }
  }
}
