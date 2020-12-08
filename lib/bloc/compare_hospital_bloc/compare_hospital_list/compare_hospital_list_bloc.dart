import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cost_of_care/bloc/compare_hospital_bloc/compare_hospital_screen/compare_hospital_screen_bloc.dart';
import 'package:cost_of_care/repository/compare_screen_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
part 'compare_hospital_list_event.dart';
part 'compare_hospital_list_state.dart';

class CompareHospitalListBloc extends Bloc<CompareHospitalListEvent, CompareHospitalListState> {
  CompareScreenRepositoryImpl compareScreenRepositoryImpl;
  CompareHospitalListBloc(this.compareScreenRepositoryImpl) : super(LoadingState());

  List<List <dynamic>> hospitalCompareData;
  int hospitalsAddedToCompare=0;
  @override
  Stream<CompareHospitalListState> mapEventToState(
    CompareHospitalListEvent event,
  ) async* {
       if(event is GetCompareData){
           yield LoadingState();
           var logger = Logger();
           logger.d("Loading state passed");
           hospitalsAddedToCompare=0;
           try{
               hospitalCompareData=await compareScreenRepositoryImpl.getListOfHospitals();
               var logger = Logger();
               logger.d("printing hospital data ");
               logger.d(hospitalCompareData);
               yield LoadedState(hospitalCompareData);

           }
           catch(e){

             yield ShowSnackBar(e.message);
             yield ErrorState(e.message);
           }

       }
       else if(event is UpdateHospitalToCompare){
               if(hospitalsAddedToCompare==2&&hospitalCompareData[event.index][13]==0){
                   yield ShowSnackBar("Cannot compare more than 2 Hospitals");
                   yield LoadedState(hospitalCompareData);
               }
              else {
                 yield LoadingState();
                 if(hospitalCompareData[event.index][13]==0)
                   hospitalsAddedToCompare++;
                 else
                   hospitalsAddedToCompare--;
                  hospitalCompareData[event.index][13] = (hospitalCompareData[event.index][13]) == 0 ? 1 : 0;
                 yield LoadedState(hospitalCompareData);
               }
      }
       else if(event is FloatingCompareHospitalButtonPress){
         if(hospitalsAddedToCompare==2) {
           List<List<dynamic>> addHospitals=new List();
           hospitalCompareData.forEach((element) {
             if (element[13] == 1) {
               addHospitals.add(element);
             }
           });
           event.compareHospitalScreenBloc.add(AddHospitals(addHospitals));
         }
         else{
           if(hospitalCompareData==null){

             yield ShowSnackBar("No hospitals available to compare for your location");
             yield ErrorState("No hospitals available to compare for your location");
           }
           else{
             yield ShowSnackBar("Please Add 2 Hospitals to compare");
             yield LoadedState(hospitalCompareData);
           }
         }
       }
  }
}
