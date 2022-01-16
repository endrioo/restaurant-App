import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission1/common/colors.dart';
import 'package:restaurant_app_submission1/provider/preferences_provider.dart';
import 'package:restaurant_app_submission1/provider/scheduling_provider.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = "/notification";

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: backgroundColor,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
            centerTitle: true,
            title: const Text('Settings'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: [
                  ListTile(
                    title: const Text(
                      "Daily Reminder",
                      style: TextStyle(color: whiteText),
                    ),
                    trailing: Consumer<SchedulingProvider>(
                      builder: (context, scheduled, _) {
                        return Switch.adaptive(
                          activeColor: secondaryColor,
                          value: provider.isDailyReminder,
                          onChanged: (value) {
                            provider.enableDailyReminder(value);
                            scheduled.scheduleReminder(value);
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
