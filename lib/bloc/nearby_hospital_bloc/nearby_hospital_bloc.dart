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
  NearbyHospitalState get initialState => LoadingState();

  @override
  Stream<NearbyHospitalState> mapEventToState(
    NearbyHospitalEvent event,
  ) async* {
    yield LoadingState();
    if (event is FetchHospitals) {
      bool checkSaved = await nearbyHospitalsServices.checkSaved();
      if (checkSaved) {
        List<Hospitals> nearby_hospital =
            await nearbyHospitalsServices.getSavedList();
        yield LoadedState(nearby_hospital);
      } else {
        final response = await nearbyHospitalsServices.fetchHospitals();
        if (response.statusCode == 200) {
          // If the server did return a 200 OK response,
          // then parse the JSON.
          List<Hospitals> nearby_hospital =
              await nearbyHospitalsServices.parseJson(response.body);
          await nearbyHospitalsServices.saveList(nearby_hospital);
          yield LoadedState(nearby_hospital);
        } else {
          // If the server did not return a 200 OK response,
          // then throw an exception.
          yield ErrorState('Network Error Unable to Fetch Data');
        }
      }
    }
  }
}
