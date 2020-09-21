import 'package:bloc_test/bloc_test.dart';
import 'package:cost_of_care/bloc/nearby_hospital_bloc/bloc.dart';
import 'package:cost_of_care/models/hospitals.dart';
import 'package:cost_of_care/repository/nearby_hospital_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNearbyHospitalRepository extends Mock
    implements NearbyHospitalsRepoImpl {}

void main() {
  NearbyHospitalBloc nearbyHospitalBloc;
  MockNearbyHospitalRepository nearbyHospitalRepo;

  setUp(() {
    nearbyHospitalRepo = MockNearbyHospitalRepository();
    nearbyHospitalBloc = NearbyHospitalBloc(nearbyHospitalRepo);
  });
  tearDown(() {
    nearbyHospitalBloc?.close();
  });

  test('initial state is correct', () {
    expect(nearbyHospitalBloc.initialState, NearbyHospitalsLoadingState());
  });
  group('NearbyHospitalBloc test', () {
    List<Hospitals> list = new List();
    list.add(Hospitals(
        "Adventist Health Ukiah Valley", Future.value(""), "distance", "78"));
    blocTest(
      'emits [NearbyHospitalsLoadingState(), NearbyHospitalsLoadedState()] when FetchHospitals is added',
      build: () {
        when(nearbyHospitalRepo.checkSaved())
            .thenAnswer((realInvocation) => false);
        Response response = new Response();
        response.statusCode = 200;
        Map<String, dynamic> map = new Map();
        response.data = map;

        when(nearbyHospitalRepo.saveList(list)).thenReturn(0);
        when(nearbyHospitalRepo.sortList(list)).thenReturn(list);
        when(nearbyHospitalRepo.parseJson(response.data))
            .thenAnswer((realInvocation) => Future.value(list));
        when(nearbyHospitalRepo.fetchHospitals())
            .thenAnswer((realInvocation) => Future.value(response));
        return nearbyHospitalBloc;
      },
      act: (bloc) => bloc.add(FetchHospitals("California")),
      expect: [NearbyHospitalsLoadingState(), NearbyHospitalsLoadedState(list)],
    );
    blocTest(
      'emits [NearbyHospitalsLoadingState(), NearbyHospitalsErrorState()] when FetchHospitals is added',
      build: () {
        when(nearbyHospitalRepo.checkSaved())
            .thenAnswer((realInvocation) => false);
        Response response = new Response();
        response.statusCode = 200;
        Map<String, dynamic> map = new Map();
        response.data = map;
        when(nearbyHospitalRepo.saveList(list)).thenReturn(0);
        when(nearbyHospitalRepo.sortList(list)).thenReturn(list);
        when(nearbyHospitalRepo.parseJson(response.data))
            .thenAnswer((realInvocation) => Future.value(list));
        when(nearbyHospitalRepo.fetchHospitals())
            .thenThrow(Exception("Network Error!"));
        return nearbyHospitalBloc;
      },
      act: (bloc) => bloc.add(FetchHospitals("California")),
      expect: [
        NearbyHospitalsLoadingState(),
        NearbyHospitalsErrorState("Network Error!")
      ],
    );
  });
}
