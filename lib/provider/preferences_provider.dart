import 'package:flutter/cupertino.dart';
import 'package:restaurant_app_submission1/helper/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyReminderPreferences();
  }

  bool _isDailyReminder = false;
  bool get isDailyReminder => _isDailyReminder;

  void _getDailyReminderPreferences() async {
    _isDailyReminder = await preferencesHelper.isDailyReminder;
    notifyListeners();
  }

  void enableDailyReminder(bool value) {
    preferencesHelper.setDailyReminder(value);
    _getDailyReminderPreferences();
  }
}
