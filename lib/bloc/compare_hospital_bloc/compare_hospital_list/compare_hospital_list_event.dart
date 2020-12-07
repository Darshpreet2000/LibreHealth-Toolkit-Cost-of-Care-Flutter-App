part of 'compare_hospital_list_bloc.dart';

abstract class CompareHospitalListEvent extends Equatable {
  const CompareHospitalListEvent();
}
class GetCompareData extends CompareHospitalListEvent{
  @override
  List<Object> get props => [];
}
class UpdateHospitalToCompare extends CompareHospitalListEvent{
  final int index;
  UpdateHospitalToCompare(this.index);
  @override
  List<Object> get props => [index];
}
class FloatingCompareHospitalButtonPress extends CompareHospitalListEvent{
 final  CompareHospitalScreenBloc compareHospitalScreenBloc;

  FloatingCompareHospitalButtonPress(this.compareHospitalScreenBloc);
  @override
  List<Object> get props =>[compareHospitalScreenBloc];

}