import 'package:curativecare/models/home_settings_model.dart';
import 'package:hive/hive.dart';
import '../main.dart';
import 'abstract/home_settings_repository.dart';

class HomeSettingsRepository implements HomeSettingsRepo {
  // Order by Distance Ascending or Descending
  @override
  Future changeSettings(HomeSettingsModel homeSettingsModel) async {
    int newRadius=homeSettingsModel.radius;
    String order=homeSettingsModel.order;
    bool isSelected=homeSettingsModel.isSelected;
    box.put('radius', newRadius.toString());
    if (order == 'Ascending')
      box.put('order', 'Ascending');
    else if (order == 'Descending') box.put('order', 'Descending');
    box.put('isSelected', isSelected);

  }
  @override
  HomeSettingsModel getInitialSettings() {
   int radius=5;
   String order='Ascending';
   bool isSelected=true;
    if(box.containsKey('radius'))
      radius= int.parse(box.get('radius'));
    if (box.containsKey('order')) {
     order= box.get('order');
      if(order=='Ascending')
        isSelected=false;
    }
    if(box.containsKey('isSelected'))
      isSelected= box.get('isSelected');
   return HomeSettingsModel(radius,order,isSelected);
  }
}
