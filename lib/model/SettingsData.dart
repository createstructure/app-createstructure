/// Manager for the application's settings.
///
/// @author @DavideC03
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsData {
  String username = "";
  String token = "";
  bool tutorial = false;
  bool _loaded = false;

  SettingsData();

  Future<void> loadData() async {
    /**
     * Loads the data from the shared preferences.
     */
    try {
      SharedPreferences.getInstance().then(
        (SharedPreferences prefs) {
          final tmp = SettingsData.fromJson(
              json.decode(prefs.getString("settings") ?? ""));
          username = tmp.username;
          token = tmp.token;
          tutorial = tmp.tutorial;
          _loaded = true;
          print("Settings loaded: " + toJson().toString());
        },
      );
    } catch (e) {
      print("No saved settings");
      username = token = "";
      tutorial = false;
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
      : username = json['username'],
        token = json['token'],
        tutorial = json['tutorial'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'token': token,
        'tutorial': tutorial,
      };

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
