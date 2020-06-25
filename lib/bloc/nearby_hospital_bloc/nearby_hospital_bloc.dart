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
            await nearbyHospitalsServices.getSavedList();
        nearby_hospital = nearbyHospitalsServices.sortList(nearby_hospital);
        yield NearbyHospitalsLoadedState(nearby_hospital);
      } else {
        final response = await nearbyHospitalsServices.fetchHospitals();
        if (response.statusCode == 200) {
          // If the server did return a 200 OK response,
          // then parse the JSON.
          List<Hospitals> nearby_hospital =
              await nearbyHospitalsServices.parseJson(response.body);
          nearbyHospitalsServices.saveList(nearby_hospital);
          nearby_hospital = nearbyHospitalsServices.sortList(nearby_hospital);
          yield NearbyHospitalsLoadedState(nearby_hospital);
        } else {
          // If the server did not return a 200 OK response,
          // then throw an exception.
          yield NearbyHospitalsErrorState('Network Error Unable to Fetch Data');
        }
      }
    }
  }
}
