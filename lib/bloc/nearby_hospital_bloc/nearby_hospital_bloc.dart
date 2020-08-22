import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:curativecare/models/hospitals.dart';
import 'package:curativecare/repository/nearby_hospital_repository_impl.dart';
import './bloc.dart';

class NearbyHospitalBloc
    extends Bloc<NearbyHospitalEvent, NearbyHospitalState> {
  final NearbyHospitalsRepoImpl nearbyHospitalsServices;

  NearbyHospitalBloc(this.nearbyHospitalsServices)
      : super(NearbyHospitalsLoadingState());
  NearbyHospitalState get initialState => NearbyHospitalsLoadingState();
  @override
  Stream<NearbyHospitalState> mapEventToState(
    NearbyHospitalEvent event,
  ) async* {
    yield NearbyHospitalsLoadingState();
    if (event is FetchHospitals) {
      bool checkSaved = nearbyHospitalsServices.checkSaved();
      if (checkSaved) {
        List<Hospitals> nearbyHospital = nearbyHospitalsServices.getSavedList();
        nearbyHospital = nearbyHospitalsServices.sortList(nearbyHospital);
        yield NearbyHospitalsLoadedState(nearbyHospital);
      } else {
        try {
          var response = await nearbyHospitalsServices.fetchHospitals();
          if (response.statusCode == 200) {
            List<Hospitals> nearbyHospital =
                await nearbyHospitalsServices.parseJson(response.data);
            nearbyHospitalsServices.saveList(nearbyHospital);
            nearbyHospital = nearbyHospitalsServices.sortList(nearbyHospital);
            if (nearbyHospital.length != 0)
              yield NearbyHospitalsLoadedState(nearbyHospital);
            else
              yield NearbyHospitalsErrorState(
                  "No Nearby Hospital Found, Try Changing Settings");
          }
        } catch (e) {
          yield NearbyHospitalsErrorState(e.message);
        }
      }
    } else if (event is NearbyHospitalShowError) {
      yield NearbyHospitalsErrorState(event.message);
    }
  }
}
