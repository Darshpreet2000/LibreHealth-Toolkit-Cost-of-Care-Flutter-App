import 'package:cost_of_care/models/home_settings_model.dart';

import '../main.dart';
import 'abstract/home_settings_repository.dart';

class HomeSettingsRepoImpl implements HomeSettingsRepo {
  // Order by Distance Ascending or Descending
  @override
  Future saveSettings(HomeSettingsModel homeSettingsModel) async {
    int newRadius = homeSettingsModel.radius;
    String order = homeSettingsModel.order;
    bool isSelected = homeSettingsModel.isSelected;
    box.put('radius', newRadius.toString());
    if (order == 'Ascending')
      box.put('order', 'Ascending');
    else if (order == 'Descending') box.put('order', 'Descending');
    box.put('isSelected', isSelected);
    box.put('latitude', homeSettingsModel.latitude);
    box.put('longitude', homeSettingsModel.longitude);
    box.put('address', homeSettingsModel.address);
    box.put('state', homeSettingsModel.state);
  }

  @override
  HomeSettingsModel getInitialSettings() {
    int radius = 15;
    String order = 'Ascending';
    bool isSelected = true;
    if (box.containsKey('radius')) radius = int.parse(box.get('radius'));
    if (box.containsKey('order')) {
      order = box.get('order');
      if (order == 'Ascending') isSelected = false;
    }
    if (box.containsKey('isSelected')) isSelected = box.get('isSelected');

    double latitude = box.get('latitude');

    double longitude = box.get('longitude');
    String address = box.get('address');
    String state = box.get('state');
    return HomeSettingsModel(
        radius, order, isSelected, latitude, longitude, address, state);
  }
}
