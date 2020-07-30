import 'package:equatable/equatable.dart';

abstract class CompareScreenEvent extends Equatable {
  const CompareScreenEvent();
}
class CompareScreenFetchData extends CompareScreenEvent{
 String hospitalNameFirst;
 String hospitalNameSecond;

 CompareScreenFetchData(this.hospitalNameFirst, this.hospitalNameSecond);

  @override
  List<Object> get props => [hospitalNameFirst,hospitalNameSecond];

}
