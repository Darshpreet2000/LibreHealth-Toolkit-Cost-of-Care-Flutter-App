import 'package:equatable/equatable.dart';

abstract class CompareScreenListEvent extends Equatable {
  const CompareScreenListEvent();
}
class CompareScreenListFetchHospitalName extends CompareScreenListEvent{

  @override
  List<Object> get props => [];
}


class CompareScreenListCompareButtonEvent extends CompareScreenListEvent{
  bool isAddedForCompare;
  int index;


  CompareScreenListCompareButtonEvent(this.isAddedForCompare, this.index);

  @override
  List<Object> get props => [isAddedForCompare,index];
}