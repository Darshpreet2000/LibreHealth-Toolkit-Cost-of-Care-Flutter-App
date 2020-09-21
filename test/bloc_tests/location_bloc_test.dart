import 'package:bloc_test/bloc_test.dart';
import 'package:cost_of_care/bloc/location_bloc/location_bloc.dart';
import 'package:cost_of_care/bloc/location_bloc/user_location_events.dart';
import 'package:cost_of_care/bloc/location_bloc/user_location_state.dart';
import 'package:cost_of_care/repository/location_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLocationRepository extends Mock implements LocationRepoImpl {}

void main() {
  LocationBloc locationBloc;
  MockLocationRepository locationRepository;
  setUp(() {
    locationRepository = MockLocationRepository();
    locationBloc = LocationBloc(locationRepository);
  });
  tearDown(() {
    locationBloc?.close();
  });

  test('initial state is correct', () {
    expect(locationBloc.initialState, LocationLoading());
  });
  group('Bloc test', () {
    final address = "India";
    blocTest(
      'emits [LocationLoading(), LocationLoaded(address)] when FetchLocation is added',
      build: () {
        when(locationRepository.checkSaved())
            .thenAnswer((realInvocation) => Future.value(false));
        when(locationRepository.getLocation()).thenAnswer(
          (_) => Future.value(address),
        );
        return locationBloc;
      },
      act: (bloc) => bloc.add(FetchLocation()),
      expect: [LocationLoading(), LocationLoaded(address)],
    );
    blocTest(
      'emits [LocationLoading(), LocationError()] when FetchLocation is added',
      build: () {
        when(locationRepository.checkSaved())
            .thenAnswer((realInvocation) => Future.value(false));
        when(locationRepository.getLocation())
            .thenThrow(Exception('Location Not Found'));
        return locationBloc;
      },
      act: (bloc) => bloc.add(FetchLocation()),
      expect: [LocationLoading(), LocationError("Location Not Found")],
    );
  });
}
