import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsData {
  String _username = "";
  String _token = "";

  SettingsData() {}

  Future<void> loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tmp =
          SettingsData.fromJson(json.decode(prefs.getString("settings")));
      _username = tmp._username;
      _token = tmp._token;
    } catch (e) {
      _username = _token = "";
    }
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    debugPrint(jsonEncode(this.toJson()));
    await prefs.setString("settings", jsonEncode(this.toJson()));
  }

  SettingsData.fromJson(Map<String, dynamic> json)
      : _username = json['username'],
        _token = json['token'];

  Map<String, dynamic> toJson() => {
        'username': _username,
        'token': _token,
      };

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  @override
  String toString() {
    return 'SettingsData{_username: $_username, _token: $_token}';
  }

  String get token => _token;

  set token(String value) {
    _token = value;
  }
}
