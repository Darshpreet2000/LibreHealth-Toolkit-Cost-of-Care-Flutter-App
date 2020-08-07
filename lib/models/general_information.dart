class GeneralInformation {
  String hospitalName,
      phoneNumber,
      hospitalType,
      hospitalOwnership,
      emergencyServices,
      hospitalOverallRating;

  GeneralInformation(
      this.hospitalName,
      this.phoneNumber,
      this.hospitalType,
      this.hospitalOwnership,
      this.emergencyServices,
      this.hospitalOverallRating);

  static fromJson(dynamic element) {
    String hospitalName,
        phoneNumber,
        hospitalType,
        hospitalOwnership,
        emergencyServices,
        hospitalOverallRating;
    hospitalName = element['hospital_name'];
    phoneNumber = element['phone_number'];
    hospitalType = element['hospital_type'];
    hospitalOwnership = element['hospital_ownership'];
    emergencyServices = element['emergency_services'];
    hospitalOverallRating = element['hospital_overall_rating'];

    GeneralInformation generalInformation = new GeneralInformation(
        hospitalName,
        phoneNumber,
        hospitalType,
        hospitalOwnership,
        emergencyServices,
        hospitalOverallRating);
    return generalInformation;
  }
}
