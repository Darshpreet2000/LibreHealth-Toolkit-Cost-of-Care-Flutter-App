import 'package:equatable/equatable.dart';

class CompareHospitalModel extends Equatable{
  String hospitalName;
  bool isAddedToCompare=false;

  CompareHospitalModel(this.hospitalName, this.isAddedToCompare);

  @override
  List<Object> get props => [hospitalName,isAddedToCompare];

}