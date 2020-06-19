import 'package:bloc/bloc.dart';
import 'package:curativecare/bloc/location_bloc/user_location_events.dart';
import 'package:curativecare/bloc/location_bloc/user_location_state.dart';
import 'package:curativecare/repository/location_repository.dart';
import 'package:curativecare/services/location_services.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationServices locationervices;

  LocationBloc(this.locationervices);

  @override
  LocationState get initialState => LocationLoading();

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    yield LocationLoading();

    if (event is FetchLocation) {
      // Emit either Loaded or Error
      yield LocationLoading();
      final bool isSaved = await locationervices.checkSaved();
      if (isSaved) {
        final String address = await locationervices.getSaved();
        yield LocationLoaded(address);
      } else {
        final String address =
            await locationervices.getLocationPermission();
        if (address == "Location Not Found" || address == "Network Problem")
          yield LocationError(address);
        else
          yield LocationLoaded(address);
      }
    } else if (event is RefreshLocation) {
      yield LocationLoading();
      final String address = await locationervices.getLocationPermission();
      if (address == "Location Not Found" || address == "Network Problem")
        yield LocationError(address);
      else
        yield LocationLoaded(address);
    }
  }
}
