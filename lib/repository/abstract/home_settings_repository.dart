import 'package:cost_of_care/models/home_settings_model.dart';

abstract class HomeSettingsRepo {
  Future saveSettings(HomeSettingsModel homeSettingsModel);

  HomeSettingsModel getInitialSettings();
}
