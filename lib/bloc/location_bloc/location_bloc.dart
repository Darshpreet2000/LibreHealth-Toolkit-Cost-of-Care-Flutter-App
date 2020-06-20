import 'package:bloc/bloc.dart';
import 'package:curativecare/bloc/location_bloc/user_location_events.dart';
import 'package:curativecare/bloc/location_bloc/user_location_state.dart';
import 'package:curativecare/repository/location_repository_impl.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepoImpl locationservices;

  LocationBloc(this.locationservices);

  @override
  LocationState get initialState => LocationLoading();

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    yield LocationLoading();

    if (event is FetchLocation) {
      // Emit either Loaded or Error
      yield LocationLoading();
      final bool isSaved = await locationservices.checkSaved();
      if (isSaved) {
        final String address = await locationservices.getSaved();
        yield LocationLoaded(address);
      } else {
        final String address = await locationservices.getLocationPermission();
        if (address == "Location Not Found" || address == "Network Problem")
          yield LocationError(address);
        else
          yield LocationLoaded(address);
      }
    } else if (event is RefreshLocation) {
      yield LocationLoading();
      final String address = await locationservices.getLocationPermission();
      if (address == "Location Not Found" || address == "Network Problem")
        yield LocationError(address);
      else
        yield LocationLoaded(address);
    }
  }
}
