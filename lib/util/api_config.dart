class ApiConfig {
  //GitLab API
  // API to download cdm from gitlab repository by providing state name & hospital name

  String downloadCDMApi =
      "https://gitlab.com/librehealth/toolkit/cost-of-care/lh-toolkit-cost-of-care-app-data-scraper/-/raw/master/CDM";
  // API to fetch List of Available Hospitals in Gitlab Repository
  String gitlabApiFetchList =
      "https://gitlab.com/api/v4/projects/18880660/repository/tree?ref=master&path=CDM/";
  // API to get total file size of a CDM, it is necessary for showing progress while downloading CDM
  String gitlabApiGetCDMFileSize =
      "https://gitlab.com/api/v4/projects/18880660/repository/files/CDM";

  // Google API
  // Getting First image from Google by searching hospital name
  String getHospitalImageFromGoogle =
      'https://www.google.com/search?tbm=isch&q=';

  //Overpass API
  // Using Overpass API to get nearby hospitals
  String nearbyHospitalApi =
      "https://lz4.overpass-api.de/api/interpreter?data=";

  //Medicare API
  // API to get available hospitals to compare state wise
  String hospitalNameUrl =
      "https://data.medicare.gov/resource/xubh-q36u.json?\$select=hospital_name&state=";
  // API to get General Information of hospital
  String generalInformationUrl =
      "https://data.medicare.gov/resource/xubh-q36u.json?\$select=hospital_name,phone_number,hospital_type,hospital_ownership,emergency_services,hospital_overall_rating&state=";
  // API to get patient experience of hospital
  String patientExperienceUrl =
      "https://data.medicare.gov/resource/avtz-f2ge.json?\$select=hospital_name,communication_with_nurses_performance_rate,communication_with_doctors_performance_rate,responsiveness_of_hospital_staff_performance_rate,care_transition_performance_rate,communication_about_medicines_performance_rate,cleanliness_and_quietness_of_hospital_environment_performance_rate&state=";
}
