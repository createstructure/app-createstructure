/**
  * Class to manage the account of the user
  *
  * @author @DavideC03
 */
import 'dart:convert';

import 'package:createstructure/model/SettingsData.dart';
import 'package:createstructure/view/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Account {
  SettingsData _settingsData = SettingsData();
  BuildContext? _context;
  static const String PERMISSION = "repo workflow admin:org user";

  Future<bool> _checkGitHub() async {
    /**
      * Check if the user has a GitHub account and the token permission
      *
      * @return bool true if the user has a GitHub account and the token permission, false otherwise
     */
    try {
      bool permissions = true;
      var r = await http.post(
        Uri.parse("https://api.github.com/user"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "token " + _settingsData.token,
        },
      );

      var response = json.decode(r.body);
      print(response.toString());
      List scopes = r.headers["x-oauth-scopes"]!.split(", ");

      PERMISSION.split(" ").forEach((element) {
        if (!scopes.contains(element)) permissions = false;
      });

      return response["login"] == _settingsData.username && permissions;
    } catch (_) {
      return false;
    }
  }

  Future<bool> checkIfAccount() async {
    /**
      * Check if the user has a GitHub account
      *
      * @return bool true if the user has a GitHub account, false otherwise
     */
    if (!_settingsData.loaded) {
      await _settingsData.loadData();
      return _settingsData.username.isNotEmpty &&
          _settingsData.username != "" &&
          _settingsData.token.isNotEmpty &&
          _settingsData.token != "" &&
          (await _checkGitHub());
    } else {
      return true; // Check already done
    }
  }

  Future<void> checkAccount() async {
    /**
      * Check if the user has a GitHub account and if not, show the login page
     */
    if (!(await checkIfAccount())) changeAccount();
  }

  void changeAccount() {
    /**
      * Show the login page
     */
    Navigator.push(_context!, MaterialPageRoute(builder: (context) => Login()));
  }

  set context(BuildContext value) {
    _context = value;
  }
}
