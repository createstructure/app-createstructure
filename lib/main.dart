import 'dart:io';

import 'package:createstructure/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(Phoenix(
    child: MyApp(),
  ));
  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Locale _locale = Locale('en');

  _syncLocale(BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getKeys().contains('refresh')) {
      prefs.remove('refresh');
      Phoenix.rebirth(context);
    }
    if (prefs.getKeys().contains('language_code')) {
      _locale = new Locale(prefs.getString('language_code'));
    } else {
      _locale = new Locale(Platform.localeName);
    }
    debugPrint(_locale.toString());
    await _locale;
  }

  @override
  Widget build(BuildContext context) {
    _syncLocale(context);
    return MaterialApp(
      title: 'createstructure',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
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
