import 'package:bloc/bloc.dart';
import 'package:curativecare/bloc/user_location_events.dart';
import 'package:curativecare/bloc/user_location_state.dart';
import 'package:curativecare/repository/location_repository.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _LocationRepository;

  LocationBloc(this._LocationRepository);

  @override
  LocationState get initialState => LocationLoading();

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    yield LocationLoading();

    if (event is FetchLocation) {
      // Emit either Loaded or Error
      yield LocationLoading();
      final bool isSaved = await _LocationRepository.checkSaved();
      if(isSaved) {
        final String address = await _LocationRepository.getSaved();
        yield LocationLoaded(address);
      }else {
        final String address = await _LocationRepository.getLocationPermission();
        if(address=="Location Not Found"||address=="Network Problem")
        yield LocationError(address);
        else
         yield LocationLoaded(address);

      }
    }
    else if (event is RefreshLocation) {
      yield LocationLoading();
        final String address = await _LocationRepository.getLocationPermission();
      if(address=="Location Not Found"||address=="Network Problem")
        yield LocationError(address);
      else
        yield LocationLoaded(address);

    }
    }
}
