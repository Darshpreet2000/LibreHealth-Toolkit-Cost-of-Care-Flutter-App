import 'package:equatable/equatable.dart';

class GeneralInformation extends Equatable {
  final String hospitalName,
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

  @override
  List<Object> get props => [
        hospitalName,
        phoneNumber,
        hospitalType,
        hospitalOwnership,
        emergencyServices,
        hospitalOverallRating
      ];
}
