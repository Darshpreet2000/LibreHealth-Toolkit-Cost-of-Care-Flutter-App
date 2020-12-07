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
}
