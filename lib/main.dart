/// Starting point for the application.
///
/// @author @DavideC03
// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:createstructure/model/SettingsData.dart';
import 'package:createstructure/view/Home.dart';
import 'package:createstructure/view/Tutorial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  /**
    * This is the main function of the app.
   */
  runApp(Phoenix(
    child: MyApp(),
  ));
  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Locale _locale = Locale('en');
  SettingsData _settingsData = SettingsData();
  static bool _forceTutorial = false; // Needs complete restart of the app
  bool _refreshed = false;

  _syncLocale(BuildContext context) async {
    /**
      * This function is used to sync the locale with the shared preferences.
      *
      * @param context The context of the app.
     */
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getKeys().contains('language_code')) {
      _locale = Locale(prefs.getString('language_code') ?? 'en');
    } else {
      _locale = Locale(Platform.localeName);
    }
    debugPrint(_locale.toString());
    return _locale;
  }

  _loadSettings(BuildContext context) async {
    /**
      * This function is used to load the settings from the shared preferences.
      *
      * @param context The context of the app.
     */
    await _settingsData.loadData();
    return _settingsData.loaded;
  }

  _refresh(BuildContext context) async {
    /**
      * This function is used to refresh the app.
      *
      * @param context The context of the app.
     */
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getKeys().contains('refresh') || !_refreshed) {
      print("Refreshing...");
      await prefs.remove('refresh');
      _refreshed = true;
      await Phoenix.rebirth(context);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    /**
      * This function is used to build the app.
      *
      * @param context The context of the app.
     */
    _loadSettings(context).then((loaded) {
      print("Settings loaded");
      return loaded;
    });
    _syncLocale(context).then((locale) {
      print("Location loaded");
      return locale;
    });
    _refresh(context).then((result) {
      print("Refresh loaded");
      return result;
    });

    return MaterialApp(
      title: 'createstructure',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (_forceTutorial || !_settingsData.tutorial ? Tutorial() : Home()),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('it'),
      ],
      locale: _locale,
    );
  }
}
