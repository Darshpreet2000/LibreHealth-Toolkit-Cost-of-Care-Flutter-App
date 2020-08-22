import 'package:curativecare/models/home_settings_model.dart';

abstract class HomeSettingsRepo {
  Future saveSettings(HomeSettingsModel homeSettingsModel);

  HomeSettingsModel getInitialSettings();
}
