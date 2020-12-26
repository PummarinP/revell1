import 'package:revell/models/ads.data.dart';
import 'package:revell/models/settings.model.dart';


class SettingsProvider {
  index() {
    Settings settings = Settings.fromMap(appSettings);
    return settings;
  }
}