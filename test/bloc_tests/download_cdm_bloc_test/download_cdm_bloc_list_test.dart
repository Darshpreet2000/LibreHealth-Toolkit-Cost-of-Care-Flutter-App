import 'package:bloc_test/bloc_test.dart';
import 'package:cost_of_care/bloc/download_cdm_bloc/download_cdm_list/bloc.dart';
import 'package:cost_of_care/models/download_cdm_model.dart';
import 'package:cost_of_care/repository/download_cdm_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDownloadCDMRepoImpl extends Mock
    implements DownloadCDMRepositoryImpl {}

void main() {
  MockDownloadCDMRepoImpl mockDownloadCDMRepoImpl;
  DownloadCdmBloc downloadCdmBloc;
  setUp(() {
    mockDownloadCDMRepoImpl = MockDownloadCDMRepoImpl();
    downloadCdmBloc = DownloadCdmBloc(mockDownloadCDMRepoImpl);
  });

  tearDown(() {
    downloadCdmBloc?.close();
  });
  test('initial state is correct', () {
    expect(downloadCdmBloc.initialState, LoadingState());
  });

  List<DownloadCdmModel> hospitals = new List();
  hospitals.add(new DownloadCdmModel("Alaska Regional Hospital", 0));

  blocTest(
    'emits [LoadingState(), LoadedState(hospitals)] when DownloadCDMFetchData is added',
    build: () {
      when(mockDownloadCDMRepoImpl.checkDataSaved(any))
          .thenAnswer((realInvocation) => Future.value(false));
      List<dynamic> response = new List();
      Map<String, dynamic> currentHospital = new Map();
      currentHospital['name'] = "Alaska Regional Hospital";
      response.add(currentHospital);
      when(mockDownloadCDMRepoImpl.fetchData(any))
          .thenAnswer((realInvocation) => Future.value(response));
      when(mockDownloadCDMRepoImpl.saveData(any, any))
          .thenAnswer((realInvocation) => 0);

      when(mockDownloadCDMRepoImpl.parseData(response))
          .thenAnswer((realInvocation) => Future.value(hospitals));
      return downloadCdmBloc;
    },
    act: (bloc) => bloc.add(DownloadCDMFetchData("California")),
    expect: [LoadingState(), LoadedState(hospitals)],
  );

  blocTest(
    'emits [LoadingState(), ErrorState] when DownloadCDMFetchData is added',
    build: () {
      when(mockDownloadCDMRepoImpl.checkDataSaved(any))
          .thenAnswer((realInvocation) => Future.value(false));
      List<dynamic> response = new List();
      Map<String, dynamic> currentHospital = new Map();
      currentHospital['name'] = "Alaska Regional Hospital";
      response.add(currentHospital);
      when(mockDownloadCDMRepoImpl.fetchData(any))
          .thenThrow(Exception("Network Problem"));
      when(mockDownloadCDMRepoImpl.saveData(any, any))
          .thenAnswer((realInvocation) => 0);

      when(mockDownloadCDMRepoImpl.parseData(response))
          .thenAnswer((realInvocation) => Future.value(hospitals));
      return downloadCdmBloc;
    },
    act: (bloc) => bloc.add(DownloadCDMFetchData("California")),
    expect: [LoadingState(), ErrorState("Network Problem")],
  );
}
