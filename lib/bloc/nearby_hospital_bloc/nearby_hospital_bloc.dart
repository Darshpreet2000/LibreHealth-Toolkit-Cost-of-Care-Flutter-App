import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:curativecare/models/hospitals.dart';
import 'package:curativecare/repository/nearby_hospital_repository_impl.dart';
import './bloc.dart';

class NearbyHospitalBloc
    extends Bloc<NearbyHospitalEvent, NearbyHospitalState> {
  final NearbyHospitalsRepoImpl nearbyHospitalsServices;

  NearbyHospitalBloc(this.nearbyHospitalsServices);

  @override
  NearbyHospitalState get initialState => NearbyHospitalsLoadingState();

  @override
  Stream<NearbyHospitalState> mapEventToState(
    NearbyHospitalEvent event,
  ) async* {
    yield NearbyHospitalsLoadingState();
    if (event is FetchHospitals) {
      bool checkSaved = await nearbyHospitalsServices.checkSaved();
      if (checkSaved) {
        List<Hospitals> nearby_hospital =
          nearbyHospitalsServices.getSavedList();
        nearby_hospital = nearbyHospitalsServices.sortList(nearby_hospital);
        yield NearbyHospitalsLoadedState(nearby_hospital);
      } else {
        try {
          var response = await nearbyHospitalsServices.fetchHospitals();
          if (response.statusCode == 200) {
            List<Hospitals> nearby_hospital =
                await nearbyHospitalsServices.parseJson(response.data);
            nearbyHospitalsServices.saveList(nearby_hospital);
            nearby_hospital = nearbyHospitalsServices.sortList(nearby_hospital);
            yield NearbyHospitalsLoadedState(nearby_hospital);
          }
        } catch (e) {
          yield NearbyHospitalsErrorState(e.message);
        }
      }
    }
    else if(event is NearbyHospitalShowError){
      yield NearbyHospitalsErrorState("Please check your internet connection and try again");
    }
  }
}
