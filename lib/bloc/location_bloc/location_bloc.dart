import 'package:bloc/bloc.dart';
import 'package:cost_of_care/bloc/location_bloc/user_location_events.dart';
import 'package:cost_of_care/bloc/location_bloc/user_location_state.dart';
import 'package:cost_of_care/repository/location_repository_impl.dart';

import '../../main.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepoImpl locationServices;

  LocationBloc(this.locationServices) : super(LocationLoading());

  get initialState => LocationLoading();

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    if (event is FetchLocation) {
      // Emit either Loaded or Error
      yield LocationLoading();
      final bool isSaved = await locationServices.checkSaved();
      if (isSaved) {
        final String address = await locationServices.getSaved();
        yield LocationLoaded(address);
      } else {
        try {
          final String address = await locationServices.getLocation();
          yield LocationLoaded(address);
        } catch (e) {
          yield LocationError(e.message);
        }
      }
    } else if (event is RefreshLocation) {
      yield LocationLoading();
      try {
        final String address = await locationServices.getLocation();
        yield LocationLoaded(address);
      } catch (e) {
        yield LocationError(e.message);
      }
    } else if (event is ChangeLocationAndSettings) {
      yield LocationLoading();
      String address = box.get('address');
      yield LocationLoaded(address);
    }
  }
}
