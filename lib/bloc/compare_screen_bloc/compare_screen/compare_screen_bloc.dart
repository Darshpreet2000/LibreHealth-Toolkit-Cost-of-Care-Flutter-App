import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:curativecare/models/compare_hospital_model.dart';
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
      yield CompareScreenLoadingState();
      try {
        List<GeneralInformation> generalInformation = new List();
        List<PatientExperience> patientExperience = new List();

        for (int i = 0; i < event.hospitalNames.length; i++) {
          CompareHospitalModel compareHospitalModel = event.hospitalNames[i];
          GeneralInformation generalInformationHospitalObj =
              await compareScreenRepositoryImpl
                  .fetchGeneralInformation(compareHospitalModel.hospitalName);
          PatientExperience patientExperienceHospitalObj =
              await compareScreenRepositoryImpl
                  .fetchPatientExperience(compareHospitalModel.hospitalName);
          generalInformation.add(generalInformationHospitalObj);
          patientExperience.add(patientExperienceHospitalObj);
        }
        yield CompareScreenLoadedState(generalInformation, patientExperience);
      } catch (e) {
        yield CompareScreenErrorState(e.message);
      }
    }
  }
}
