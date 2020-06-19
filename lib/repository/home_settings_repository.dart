
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeSettingsRepo{
  Future changeRadius(int newRadius);
  Future changeOrder(String order);
}

class HomeSettingsRepository implements HomeSettingsRepo{
  SharedPreferences prefs;
  String radius;
  @override
  Future changeRadius(int newRadius) async {
    prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('radius')) {
      radius = prefs.getString('radius');
     prefs.setString('radius', newRadius.toString());
    }
    else{
      prefs.setString('radius', newRadius.toString());
    }
  }

  // Order by Distance Ascending or Descending
  @override
  Future changeOrder(String order) {
    var order = Hive.box('myBox');
    if(order=='ascending')
      order.put('order','ascending');
   else if(order=='descending')
     order.put('order', 'descending');
  }

}