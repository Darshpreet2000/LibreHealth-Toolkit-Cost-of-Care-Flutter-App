class ApiConfig{

  //Medicare API
  String hospitalNameUrl =
      "https://data.medicare.gov/resource/xubh-q36u.json?\$select=hospital_name&state=";
  String generalInformationUrl =
      "https://data.medicare.gov/resource/xubh-q36u.json?\$select=hospital_name,phone_number,hospital_type,hospital_ownership,emergency_services,hospital_overall_rating&state=";
  String patientExperienceUrl =
      "https://data.medicare.gov/resource/avtz-f2ge.json?\$select=hospital_name,communication_with_nurses_performance_rate,communication_with_doctors_performance_rate,responsiveness_of_hospital_staff_performance_rate,care_transition_performance_rate,communication_about_medicines_performance_rate,cleanliness_and_quietness_of_hospital_environment_performance_rate&state=";

}