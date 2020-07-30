import 'package:equatable/equatable.dart';

class CompareHospitalModel extends Equatable{
  String hospitalName;
  bool isAddedToCompare=false;

  CompareHospitalModel(this.hospitalName, this.isAddedToCompare);
  CompareHospitalModel copyWith({String hospitalName, bool isAddedToCompare}) {
    return CompareHospitalModel(this.hospitalName, this.isAddedToCompare);
  }
  @override
  String toString() {
    return 'Todo { complete: $hospitalName, name: $isAddedToCompare }';
  }

  @override
  List<Object> get props => [hospitalName,isAddedToCompare];

}