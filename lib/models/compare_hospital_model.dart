import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'compare_hospital_model.g.dart';

@HiveType(typeId: 2)
class CompareHospitalModel extends Equatable {
  @HiveField(0)
  String hospitalName;
  @HiveField(1)
  bool isAddedToCompare = false;

  CompareHospitalModel(this.hospitalName, this.isAddedToCompare);
  CompareHospitalModel copyWith({String hospitalName, bool isAddedToCompare}) {
    return CompareHospitalModel(this.hospitalName, this.isAddedToCompare);
  }

  @override
  String toString() {
    return 'Todo { complete: $hospitalName, name: $isAddedToCompare }';
  }

  @override
  List<Object> get props => [hospitalName, isAddedToCompare];
}
