import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_progress/bloc.dart';
import 'package:curativecare/network/gitlab_api_client.dart';
import 'package:curativecare/repository/download_cdm_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDio extends Mock implements Dio {}

void main() {
  GitLabApiClient gitlabApiClient;
  MockDio mockDio;
  setUp(() {
    mockDio = MockDio();
    gitlabApiClient = GitLabApiClient(mockDio);
  });
  group('fetchStates test', () {
    test(
      "fetch statesName Successfully",
      () async {
        List<String> statesName = new List();
        statesName.add("California");
        Map<String, dynamic> currentHospital = new Map();
        currentHospital['name'] = "California";
        List<dynamic> newList = new List();
        newList.add(currentHospital);
        Response response = new Response();
        response.statusCode = 200;
        response.data = newList;
        when(mockDio.get(any))
            .thenAnswer((realInvocation) => Future.value(response));
        expect(await gitlabApiClient.fetchStatesName(), statesName);
      },
    );
    test(
      "fetch statesName Unsuccessfully",
      () async {
        List<String> statesName = new List();
        statesName.add("California");
        Map<String, dynamic> currentHospital = new Map();
        currentHospital['name'] = "California";
        List<dynamic> newList = new List();
        newList.add(currentHospital);
        Response response = new Response();
        response.statusCode = 200;
        response.data = newList;
        when(mockDio.get(any)).thenAnswer((realInvocation) => throw DioError);
        expect(gitlabApiClient.fetchStatesName(), throwsException);
      },
    );
  });

  group('getAvailableCdm for a state test', () {
    test(
      "fetch statesName Successfully",
      () async {
        List<String> statesName = new List();
        statesName.add("California");
        Map<String, dynamic> currentHospital = new Map();
        currentHospital['name'] = "California";
        Headers headerMap = new Headers();
        headerMap.add("x-total-pages", "1");
        List<dynamic> newList = new List();
        newList.add(currentHospital);
        Response response = new Response();
        response.headers = headerMap;
        response.statusCode = 200;
        response.data = newList;
        when(mockDio.get(any))
            .thenAnswer((realInvocation) => Future.value(response));
        expect(await gitlabApiClient.getAvailableCdm("California"), newList);
      },
    );
    test(
      "fetch availableCDM Unsuccessfully",
      () async {
        List<String> statesName = new List();
        statesName.add("California");
        Map<String, dynamic> currentHospital = new Map();
        currentHospital['name'] = "California";
        List<dynamic> newList = new List();
        newList.add(currentHospital);
        Response response = new Response();
        response.statusCode = 200;
        response.data = newList;
        when(mockDio.get(any)).thenAnswer((realInvocation) => throw DioError);
        expect(gitlabApiClient.getAvailableCdm("California"), throwsException);
      },
    );
  });

  group('getCSVFileSize for a state test', () {
    test(
      "fetch getCSVFileSize Successfully",
      () async {
        List<String> statesName = new List();
        statesName.add("California");
        Map<String, dynamic> currentHospital = new Map();
        currentHospital['name'] = "California";
        Headers headerMap = new Headers();
        headerMap.add("x-gitlab-size", "1");
        List<dynamic> newList = new List();
        newList.add(currentHospital);
        Response response = new Response();
        response.headers = headerMap;
        response.statusCode = 200;
        response.data = newList;
        when(mockDio.head(any))
            .thenAnswer((realInvocation) => Future.value(response));
        expect(
            await gitlabApiClient.getCSVFileSize(DownloadFileButtonClick(
                0,
                "Alaska Regional Hospital",
                "Alaska",
                DownloadFileButtonBloc(DownloadCDMRepositoryImpl()))),
            1);
      },
    );
    test(
      "fetch getCSVFileSize Unsuccessfully",
      () async {
        List<String> statesName = new List();
        statesName.add("California");
        Map<String, dynamic> currentHospital = new Map();
        currentHospital['name'] = "California";
        Headers headerMap = new Headers();
        headerMap.add("x-gitlab-size", "1");
        List<dynamic> newList = new List();
        newList.add(currentHospital);
        Response response = new Response();
        response.headers = headerMap;
        response.statusCode = 200;
        response.data = newList;
        when(mockDio.head(any)).thenAnswer((realInvocation) => throw DioError);
        expect(
            gitlabApiClient.getCSVFileSize(DownloadFileButtonClick(
                0,
                "Alaska Regional Hospital",
                "Alaska",
                DownloadFileButtonBloc(DownloadCDMRepositoryImpl()))),
            throwsException);
      },
    );
  });
}
