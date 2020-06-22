import 'package:curativecare/models/home_settings_model.dart';
import 'package:hive/hive.dart';

abstract class HomeSettingsRepo {
  Future changeSettings(HomeSettingsModel homeSettingsModel);
  HomeSettingsModel getInitialSettings();
}
