import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cost_of_care/repository/compare_screen_repository_impl.dart';
import 'package:equatable/equatable.dart';

part 'compare_hospital_screen_event.dart';
part 'compare_hospital_screen_state.dart';

class CompareHospitalScreenBloc
    extends Bloc<CompareHospitalScreenEvent, CompareHospitalScreenState> {
  CompareHospitalScreenBloc(this.compareScreenRepositoryImpl)
      : super(CompareHospitalScreenInitial());
  CompareScreenRepositoryImpl compareScreenRepositoryImpl;
  @override
  Stream<CompareHospitalScreenState> mapEventToState(
    CompareHospitalScreenEvent event,
  ) async* {
    if (event is AddHospitals) {
      yield LoadedState(event.hospitalToCompare);
    }
  }
}
