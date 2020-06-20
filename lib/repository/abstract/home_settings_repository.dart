import 'package:hive/hive.dart';

abstract class HomeSettingsRepo {
  Future changeRadius(int newRadius);

  Future changeOrder(String order);
}

class HomeSettingsRepository implements HomeSettingsRepo {
  String radius;

  @override
  Future changeRadius(int newRadius) async {
    var box = await Hive.openBox('myBox');

    box.put('radius', newRadius.toString());
  }

  // Order by Distance Ascending or Descending
  @override
  Future changeOrder(String order) async {
    var box = await Hive.openBox('myBox');

    if (order == 'ascending')
      box.put('order', 'ascending');
    else if (order == 'descending') box.put('order', 'descending');
  }
}
