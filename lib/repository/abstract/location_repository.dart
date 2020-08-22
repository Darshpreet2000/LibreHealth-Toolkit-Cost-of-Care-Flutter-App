abstract class LocationRepository {
  Future<String> getLocation(); //Get address & coordinates of user location
  Future<bool> checkSaved();

  Future<String> getSaved();
}
