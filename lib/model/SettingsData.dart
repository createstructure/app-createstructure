/**
  * Manager for the application's settings.
  *
  * @author @DavideC03
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsData {
  String _username = "";
  String _token = "";
  bool _tutorial = false;
  bool _loaded = false;

  SettingsData() {}

  Future<void> loadData() async {
    /**
     * Loads the data from the shared preferences.
     */
    try {
      SharedPreferences.getInstance().then(
        (SharedPreferences prefs) {
          final tmp = SettingsData.fromJson(
              json.decode(prefs.getString("settings") ?? ""));
          _username = tmp._username;
          _token = tmp._token;
          _tutorial = tmp._tutorial;
          _loaded = true;
          print("Settings loaded: " + toJson().toString());
        },
      );
    } catch (e) {
      print("No saved settings");
      _username = _token = "";
      _tutorial = false;
      _loaded = true;
    }
  }

  Future<void> saveData() async {
    /**
     * Saves the data to the shared preferences.
     */
    final prefs = await SharedPreferences.getInstance();
    debugPrint(jsonEncode(this.toJson()));
    await prefs.setString("settings", jsonEncode(this.toJson()));
  }

  Future<void> saveDataContext(BuildContext context) async {
    /**
     * Saves the data to the shared preferences.
     *
     * @param context The context of the application, used to reload it
     */
    await saveData();
    await Phoenix.rebirth(context);
  }

  SettingsData.fromJson(Map<String, dynamic> json)
      : _username = json['username'],
        _token = json['token'],
        _tutorial = json['tutorial'];

  Map<String, dynamic> toJson() => {
        'username': _username,
        'token': _token,
        'tutorial': _tutorial,
      };

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String get token => _token;

  set token(String value) {
    _token = value;
  }

  bool get tutorial => _tutorial;

  set tutorial(bool value) {
    _tutorial = value;
  }

  bool get loaded => _loaded;

  @override
  String toString() {
    /**
     * Returns a string representation of the object.
     *
     * @return A string representation of the object.
     */
    return toJson().toString();
  }
}
