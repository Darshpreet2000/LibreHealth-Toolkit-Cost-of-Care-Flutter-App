import 'package:curativecare/models/home_settings_model.dart';

abstract class HomeSettingsRepo {
  Future changeSettings(HomeSettingsModel homeSettingsModel);

  HomeSettingsModel getInitialSettings();
}
