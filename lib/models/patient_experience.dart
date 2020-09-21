import 'package:equatable/equatable.dart';

class PatientExperience extends Equatable {
  final String hospitalName,
      communicationWithNursesPerformanceRate,
      communicationWithDoctorsPerformanceRate,
      responsivenessOfHospitalStaffPerformanceRate,
      careTransitionPerformanceRate,
      communicationAboutMedicinesPerformanceRate,
      cleanlinessAndQuietnessOfHospitalEnvironmentPerformanceRate;

  PatientExperience(
    this.hospitalName,
    this.communicationWithNursesPerformanceRate,
    this.communicationWithDoctorsPerformanceRate,
    this.responsivenessOfHospitalStaffPerformanceRate,
    this.careTransitionPerformanceRate,
    this.communicationAboutMedicinesPerformanceRate,
    this.cleanlinessAndQuietnessOfHospitalEnvironmentPerformanceRate,
  );

  @override
  List<Object> get props => [
        hospitalName,
        communicationWithNursesPerformanceRate,
        communicationWithDoctorsPerformanceRate,
        responsivenessOfHospitalStaffPerformanceRate,
        careTransitionPerformanceRate,
        communicationAboutMedicinesPerformanceRate,
        cleanlinessAndQuietnessOfHospitalEnvironmentPerformanceRate
      ];
}
