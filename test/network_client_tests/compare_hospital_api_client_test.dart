import 'package:cost_of_care/models/compare_hospital_model.dart';
import 'package:cost_of_care/models/general_information.dart';
import 'package:cost_of_care/models/patient_experience.dart';
import 'package:cost_of_care/network/compare_hospital_api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDio extends Mock implements Dio {}

void main() {
  MockDio mockDio;
  setUp(() {
    mockDio = MockDio();
  });
  test(
    "fetch hospitals Successfully",
    () async {
      //act
      List<CompareHospitalModel> hospitalsName = new List();
      hospitalsName
          .add(new CompareHospitalModel("Alaska Regional Hospital", false));
      List<dynamic> elements = new List();
      Map<String, dynamic> currentHospital = new Map();
      currentHospital['hospital_name'] = "Alaska Regional Hospital";
      elements.add(currentHospital);
      Response response = new Response();
      response.statusCode = 200;
      response.data = elements;
      when(mockDio.get(any))
          .thenAnswer((realInvocation) => Future.value(response));
      CompareHospitalAPIClient compareHospitalAPIClient =
          new CompareHospitalAPIClient(mockDio);
      expect(await compareHospitalAPIClient.fetchHospitalsName("stateName"),
          hospitalsName);
    },
  );

  test(
    "fetch hospitals Unsuccessfully",
    () async {
      //act
      when(mockDio.get(any)).thenAnswer((realInvocation) => throw DioError);
      CompareHospitalAPIClient compareHospitalAPIClient =
          new CompareHospitalAPIClient(mockDio);
      expect(compareHospitalAPIClient.fetchHospitalsName("stateName"),
          throwsException);
    },
  );

  test(
    "fetch GeneralInformation Unsuccessfully",
    () async {
      //act
      when(mockDio.get(any)).thenAnswer((realInvocation) => throw DioError);
      CompareHospitalAPIClient compareHospitalAPIClient =
          new CompareHospitalAPIClient(mockDio);
      expect(
          compareHospitalAPIClient.fetchGeneralInformation(
              "hospitalsName", " stateName"),
          throwsException);
    },
  );

  test(
    "fetch PatientExperience Unsuccessfully",
    () async {
      //act
      when(mockDio.get(any)).thenAnswer((realInvocation) => throw DioError);
      CompareHospitalAPIClient compareHospitalAPIClient =
          new CompareHospitalAPIClient(mockDio);
      expect(
          compareHospitalAPIClient.fetchPatientExperience(
              "hospitalsName", "stateName"),
          throwsException);
    },
  );

  test(
    "fetch GeneralInformation Successfully",
    () async {
      //act
      List<dynamic> elements = new List();
      Map<String, dynamic> currentHospital = new Map();
      currentHospital['hospital_name'] = "Alaska Regional Hospital";
      currentHospital['phone_number'] = "767879898";
      currentHospital['hospital_type'] = "General";
      currentHospital['hospital_ownership'] = "Private";
      currentHospital['emergency_services'] = "Yes";
      currentHospital['hospital_overall_rating'] = "4";
      elements.add(currentHospital);
      Response response = new Response();
      response.statusCode = 200;
      response.data = elements;
      GeneralInformation generalInformation = new GeneralInformation(
          "Alaska Regional Hospital",
          "767879898",
          "General",
          "Private",
          "Yes",
          "4");
      when(mockDio.get(any))
          .thenAnswer((realInvocation) => Future.value(response));
      CompareHospitalAPIClient compareHospitalAPIClient =
          new CompareHospitalAPIClient(mockDio);
      expect(
          await compareHospitalAPIClient.fetchGeneralInformation(
              "hospitalsName", " stateName"),
          generalInformation);
    },
  );

  test(
    "fetch PatientExperience Successfully",
    () async {
      //act
      List<dynamic> elements = new List();
      Map<String, dynamic> currentHospital = new Map();
      currentHospital['hospital_name'] = "Alaska Regional Hospital";
      currentHospital['communication_with_nurses_performance_rate'] =
          "767879898";
      currentHospital['communication_with_doctors_performance_rate'] =
          "General";
      currentHospital['responsiveness_of_hospital_staff_performance_rate'] =
          "Private";
      currentHospital['care_transition_performance_rate'] = "Yes";
      currentHospital['communication_about_medicines_performance_rate'] = "4";
      currentHospital[
              'cleanliness_and_quietness_of_hospital_environment_performance_rate'] =
          "4";
      elements.add(currentHospital);
      Response response = new Response();
      response.statusCode = 200;
      response.data = elements;
      PatientExperience patientExperience = new PatientExperience(
          "Alaska Regional Hospital",
          "767879898",
          "General",
          "Private",
          "Yes",
          "4",
          "4");
      when(mockDio.get(any))
          .thenAnswer((realInvocation) => Future.value(response));
      CompareHospitalAPIClient compareHospitalAPIClient =
          new CompareHospitalAPIClient(mockDio);
      expect(
          await compareHospitalAPIClient.fetchPatientExperience(
              "hospitalsName", " stateName"),
          patientExperience);
    },
  );
}
