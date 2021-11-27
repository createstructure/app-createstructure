import 'dart:convert';

import 'package:createstructure/model/Answers.dart';
import 'package:createstructure/model/SettingsData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';

class HomeViewModel extends MultipleFutureViewModel {
  static const DEFAULT_FUNCTION = "DEFAULT_FUNCTION";
  SettingsData _settingsData = new SettingsData();

  @override
  Map<String, Future Function()> get futuresMap =>
      {DEFAULT_FUNCTION: defaultFunction};

  init() async {
    await _settingsData.loadData();
  }

  String _getBody(Answers answers) {
    return (answers.isOrg && answers.isOrg != null)
        ? (json.encode({
            "token": _settingsData.token,
            "username": _settingsData.username,
            "answers": {
              "name": answers.name,
              "template": answers.template,
              "descr": answers.descr,
              "prefix": answers.prefix,
              "isOrg": answers.isOrg,
              "private": answers.private,
              "org": answers.org,
              "team": answers.team
            }
          }))
        : (json.encode({
            "token": _settingsData.token,
            "username": _settingsData.username,
            "answers": {
              "name": answers.name,
              "template": answers.template,
              "descr": answers.descr,
              "prefix": answers.prefix,
              "isOrg": answers.isOrg,
              "private": answers.private
            }
          }));
  }

  sendData(Answers answers, BuildContext context) async {
    await init();
    final response = await http.post(
        Uri.parse(
            "https://www.castellanidavide.it/other/rest/product/create.php"),
        headers: {"Content-Type": "application/json"},
        body: _getBody(answers));

    var r = json.decode(response.body);

    /*Fluttertoast.showToast(
      msg: (r["message"] == "error"
          ? AppLocalizations.of(context)!.error + r["error"]
          : r["message"]),
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
    );*/
    debugPrint(_getBody(answers));
    print("${response.statusCode}");
    print("${response.body}");
  }
/*
  String getUsername() {
    _settingsData.loadData();
    print("Username: " + _settingsData.username);
    return _settingsData.username;
  }

  String getToken() {
    _settingsData.loadData();
    print("Token: " + _settingsData.token);
    return _settingsData.token;
  }
*/

  void checkTutorial(BuildContext context) {
    if (_settingsData.tutorial) {
      print("Tutorial done");
    } else {
      print("tutorial to do");
    }
  }

  Future<String> defaultFunction() async {
    return "";
  }
}
