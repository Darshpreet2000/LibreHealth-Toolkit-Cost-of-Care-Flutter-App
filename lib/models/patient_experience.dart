class PatientExperience {
  String hospitalName,
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

  static fromJson(dynamic element) {
    String hospitalName,
        communicationWithNursesPerformanceRate,
        communicationWithDoctorsPerformanceRate,
        responsivenessOfHospitalStaffPerformanceRate,
        careTransitionPerformanceRate,
        communicationAboutMedicinesPerformanceRate,
        cleanlinessAndQuietnessOfHospitalEnvironmentPerformanceRate,
        dischargeInformationPerformanceRate;
    hospitalName = element['hospital_name'];
    communicationWithNursesPerformanceRate =
        element['communication_with_nurses_performance_rate'];
    communicationWithDoctorsPerformanceRate =
        element['communication_with_doctors_performance_rate'];
    responsivenessOfHospitalStaffPerformanceRate =
        element['responsiveness_of_hospital_staff_performance_rate'];
    careTransitionPerformanceRate = element['care_transition_performance_rate'];
    communicationAboutMedicinesPerformanceRate =
        element['communication_about_medicines_performance_rate'];
    cleanlinessAndQuietnessOfHospitalEnvironmentPerformanceRate = element[
        'cleanliness_and_quietness_of_hospital_environment_performance_rate'];
    dischargeInformationPerformanceRate =
        element['discharge_information_performance_rate'];
    PatientExperience patientExperience = new PatientExperience(
        hospitalName,
        communicationWithNursesPerformanceRate,
        communicationWithDoctorsPerformanceRate,
        responsivenessOfHospitalStaffPerformanceRate,
        careTransitionPerformanceRate,
        communicationAboutMedicinesPerformanceRate,
        cleanlinessAndQuietnessOfHospitalEnvironmentPerformanceRate);
    return patientExperience;
  }
}
