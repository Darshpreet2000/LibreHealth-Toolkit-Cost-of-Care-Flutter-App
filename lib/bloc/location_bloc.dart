import 'package:bloc/bloc.dart';
import 'package:curativecare/bloc/user_location_events.dart';
import 'package:curativecare/bloc/user_location_state.dart';
import 'package:curativecare/models/location.dart';
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
      try {
        final Location location = await _LocationRepository.getLocation();
        yield LocationLoaded(location);
      } on NetworkError {
        yield LocationError("Couldn't fetch weather. Is the device online?");
      }
    }
    else if (event is RefreshLocation) {
      yield LocationLoading();
      try {
        final Location location = await repository.fetchDetailedWeather();
        yield LocationLoaded(location);
      } on NetworkError {
        yield LocationError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
  
}