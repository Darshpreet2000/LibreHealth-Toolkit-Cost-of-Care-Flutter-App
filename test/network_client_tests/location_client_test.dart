import 'package:cost_of_care/models/user_location_data.dart';
import 'package:cost_of_care/network/location_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:location/location.dart';
import 'package:mockito/mockito.dart';

class MockGeoLocatorClient extends Mock implements GeocodingPlatform {}

class MockLocationClient extends Mock implements Location {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('getCurrentLocation', () {
    final geoLocatorClient = MockGeoLocatorClient();
    final location = MockLocationClient();
    LocationClient locationClient =
        new LocationClient(geoLocatorClient,location);
    // Using Mock Data
    List<Placemark> placeMark = [];
    placeMark.add(PlacemarkFactory.createMockPlacemark());
    test('returns location if http call Successful', () async {
      when(location.getLocation()).thenAnswer(
          (_) async => Future.value(PositionFactory.createMockPosition()));
      when(geoLocatorClient.placemarkFromCoordinates(any, any,localeIdentifier: "en"))
          .thenAnswer((_) async => Future.value(placeMark));
      expect(
          await locationClient.getCurrentLocation(), isA<UserLocationData>());
    });
    test('returns Exception if http call Unsuccessful', () async {
      when(location.getLocation()).thenAnswer((_) async => throw Exception());
      when(geoLocatorClient.placemarkFromCoordinates(any, any))
          .thenAnswer((_) async => Future.value(placeMark));
      expect(locationClient.getCurrentLocation(), throwsException);
    });
  });
}

class PlacemarkFactory {
  static Placemark createMockPlacemark() {
    return Placemark(
        administrativeArea: 'Overijssel',
        country: 'Netherlands',
        isoCountryCode: 'NL',
        locality: 'Enschede',
        name: 'Gronausestraat',
        postalCode: '',
        subAdministrativeArea: 'Enschede',
        subLocality: 'Enschmarke',
        subThoroughfare: '',
        thoroughfare: 'Gronausestraat');
  }
}

class PositionFactory {
  static LocationData createMockPosition() {
    Map<String, double> dataMap = new Map();
    dataMap['latitude'] = 10;
    dataMap['longitude'] = 10;
    dataMap['accuracy'] = 10;
    dataMap['altitude'] = 10;
    dataMap['speed'] = 10;
    dataMap['speed_accuracy'] = 10;
    dataMap['heading'] = 10;
    dataMap['time'] = 10;
    return LocationData.fromMap(dataMap);
  }
}
