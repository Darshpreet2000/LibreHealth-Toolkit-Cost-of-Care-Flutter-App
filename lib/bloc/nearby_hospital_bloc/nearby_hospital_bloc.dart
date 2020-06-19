import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:curativecare/models/nearby_hospital.dart';
import 'package:curativecare/repository/nearby_hospitals_repository.dart';
import './bloc.dart';

class NearbyHospitalBloc extends Bloc<NearbyHospitalEvent, NearbyHospitalState> {
  final NearbyHospitals_Repository nearbyHospitalsRepository;

  NearbyHospitalBloc(this.nearbyHospitalsRepository);

  @override
  NearbyHospitalState get initialState => LoadingState();

  @override
  Stream<NearbyHospitalState> mapEventToState(NearbyHospitalEvent event,) async* {
      yield LoadingState();
     if(event is FetchHospitals){
        final response = await nearbyHospitalsRepository.fetch_hospitals();
       if (response.statusCode == 200) {
         // If the server did return a 200 OK response,
         // then parse the JSON.
       List<NearbyHospital> nearby_hospital=await nearbyHospitalsRepository.parse_json(response.body);
       yield LoadedState(nearby_hospital);
       } else {
         // If the server did not return a 200 OK response,
         // then throw an exception.
         yield ErrorState('Network Error Unable to Fetch Data');
       }
     }

  }
}
