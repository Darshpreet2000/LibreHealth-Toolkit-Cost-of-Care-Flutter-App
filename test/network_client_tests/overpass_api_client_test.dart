import 'package:curativecare/network/overpass_api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';

class MockDio extends Mock implements Dio {}

class MockBox extends Mock implements Box {}

void main() {
  MockDio mockDio;
  MockBox mockBox;
  setUp(() {
    mockDio = MockDio();
    mockBox = MockBox();
  });
  test(
    "fetch nearby hospital Successfully",
    () async {
      when(mockBox.get('latitude')).thenAnswer((realInvocation) => "99898678");

      when(mockBox.get('longitude')).thenAnswer((realInvocation) => "99898678");

      when(mockBox.containsKey("radius")).thenAnswer((realInvocation) => false);
      //act
      Response response = new Response();
      response.statusCode = 200;
      response.data =
          """{"version":0.6,"generator":"Overpass API 0.7.56.3 eb200aeb","osm3s":{"timestamp_osm_base":"2020-08-11T19:04:03Z","copyright":"The data included in this document is from www.openstreetmap.org. The data is made available under ODbL."},"elements":[{"type":"way","id":392014932,"center":{"lat":64.8316363,"lon":-147.7405074},"nodes":[4464792360,4464792362,4464792364,4464792366,4464792368,4464792369,4464792370,4464792371,4464792373,4464792372,4464792367,4464792365,4464792363,4464792361,4464792359,4464792358,4464792353,4464792352,4464792354,4464792355,4464792357,4464792356,4464792360],"tags":{"addr:city":"Fairbanks","addr:housenumber":"1650","addr:postcode":"99701","addr:street":"Cowles Street","amenity":"hospital","beds":"152","emergency":"yes","healthcare":"hospital","name":"Fairbanks Memorial Hospital","phone":"+1 907 452 8181","website":"http://www.fmhdc.com/"}}]}""";
      when(mockDio.get(any))
          .thenAnswer((realInvocation) => Future.value(response));
      OverpassAPIClient overpassAPIClient = new OverpassAPIClient();
      overpassAPIClient.dio = mockDio;
      overpassAPIClient.openBox = mockBox;
      expect(overpassAPIClient.fetchNearbyHospitals(), isA<Future<dynamic>>());
    },
  );

  test(
    "fetch nearby hospital Error",
    () async {
      when(mockBox.get('latitude')).thenAnswer((realInvocation) => "99898678");
      when(mockBox.get('longitude')).thenAnswer((realInvocation) => "99898678");
      when(mockBox.containsKey("radius")).thenAnswer((realInvocation) => false);
      //act
      Response response = new Response();
      response.statusCode = 404;
      response.data = "No Data Found";
      when(mockDio.get(any))
          .thenAnswer((realInvocation) => Future.value(response));
      OverpassAPIClient overpassAPIClient = new OverpassAPIClient();
      overpassAPIClient.dio = mockDio;
      overpassAPIClient.openBox = mockBox;
      expect(overpassAPIClient.fetchNearbyHospitals(), throwsException);
    },
  );

  test(
    "fetch nearby hospital Dio Http Error",
    () async {
      when(mockBox.get('latitude')).thenAnswer((realInvocation) => "99898678");
      when(mockBox.get('longitude')).thenAnswer((realInvocation) => "99898678");
      when(mockBox.containsKey("radius")).thenAnswer((realInvocation) => false);
      //act
      when(mockDio.get(any)).thenAnswer((realInvocation) => throw DioError);
      OverpassAPIClient overpassAPIClient = new OverpassAPIClient();
      overpassAPIClient.dio = mockDio;
      overpassAPIClient.openBox = mockBox;
      expect(overpassAPIClient.fetchNearbyHospitals(), throwsException);
    },
  );
}
