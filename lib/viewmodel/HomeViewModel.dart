import 'dart:convert';

import 'package:createstructure/model/Answers.dart';
import 'package:createstructure/model/SettingsData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';

class HomeViewModel extends MultipleFutureViewModel {
  static const DEFAULT_FUNCTION = "DEFAULT_FUNCTION";
  Map<String, TextEditingController> _textEditingControllers = {};
  SettingsData _settingsData = new SettingsData();
  Answers _answers = new Answers();
  int _index = 0;
  BuildContext? _context;

  List<Step> stepList() => [
        Step(
          state: StepState.complete,
          isActive: _index >= 0,
          title: Text(AppLocalizations.of(_context!)!.step0),
          content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _getPadding(
                  Icons.format_quote,
                  "name",
                  AppLocalizations.of(_context!)!.question_1_short,
                  AppLocalizations.of(_context!)!.question_1_long,
                ),
                _getPadding(
                  Icons.description,
                  "decr",
                  AppLocalizations.of(_context!)!.question_3_short,
                  AppLocalizations.of(_context!)!.question_3_long,
                ),
                _getPadding(
                  Icons.public,
                  "private",
                  AppLocalizations.of(_context!)!.question_7_short,
                  AppLocalizations.of(_context!)!.question_7_long,
                ),
                _getPadding(
                  Icons.navigate_before,
                  "prefix",
                  AppLocalizations.of(_context!)!.question_4_short,
                  AppLocalizations.of(_context!)!.question_4_long,
                ),
              ],
            ),
          ),
        ),
        Step(
          state: StepState.complete,
          isActive: _index >= 1,
          title: Text(AppLocalizations.of(_context!)!.step1),
          content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _getPadding(
                  Icons.copy,
                  "template",
                  AppLocalizations.of(_context!)!.question_2_short,
                  AppLocalizations.of(_context!)!.question_2_long,
                ),
              ],
            ),
          ),
        ),
        Step(
          state: StepState.complete,
          isActive: _index >= 2,
          title: Text(AppLocalizations.of(_context!)!.step2),
          content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _getPadding(
                  Icons.business,
                  "org",
                  AppLocalizations.of(_context!)!.question_5_short,
                  AppLocalizations.of(_context!)!.question_5_long,
                ),
                _getPadding(
                  Icons.group,
                  "team",
                  AppLocalizations.of(_context!)!.question_6_short,
                  AppLocalizations.of(_context!)!.question_6_long,
                ),
              ],
            ),
          ),
        ),
        Step(
          state: StepState.complete,
          isActive: _index >= 3,
          title: Text(AppLocalizations.of(_context!)!.step3),
          content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(_answers.toString()),
              ],
            ),
          ),
        ),
      ];

  @override
  Map<String, Future Function()> get futuresMap =>
      {DEFAULT_FUNCTION: defaultFunction};

  init() async {
    await _settingsData.loadData();
  }

  message(String message) {
    print(message);
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  warning(String error) =>
      message(AppLocalizations.of(_context!)!.error + error);

  String _getBody() {
    Map body = Map();
    Map payload = Map();
    Map answers = Map();
    body["request"] = "create_repo";
    if (_settingsData.username != "") {
      payload["username"] = _settingsData.username;
    } else {
      warning(AppLocalizations.of(_context!)!.error_username);
      return "error";
    }
    if (_settingsData.token != "") {
      payload["token"] = _settingsData.token;
    } else {
      warning(AppLocalizations.of(_context!)!.error_token);
      return "error";
    }
    if (_answers.name != "") {
      answers["name"] = _answers.name;
    } else {
      warning(AppLocalizations.of(_context!)!.error_repo_name);
      return "error";
    }
    if (_answers.template != "") answers["template"] = _answers.template;
    if (_answers.descr != "") answers["descr"] = _answers.descr;
    if (_answers.prefix != "") answers["prefix"] = _answers.prefix;
    answers["private"] = _answers.private;
    if (_answers.isOrg) {
      answers["org"] = _answers.org;
      if (_answers.team != "") answers["team"] = _answers.team;
    }
    payload["answers"] = answers;
    body["payload"] = payload;
    print(jsonEncode(body));
    return jsonEncode(body);
  }

  sendData() async {
    await init();
    String request = _getBody();
    if (request == "error") return;
    final response = await http.post(
      Uri.parse("https://www.castellanidavide.it/other/createstructure/api/"),
      headers: {"Content-Type": "application/json"},
      body: request,
    );

    var r = json.decode(response.body);

    if (r["code"] == 200) {
      message(AppLocalizations.of(_context!)!.code_200);
    }
  }

  _getPadding(IconData icon, String key, String title, String description) {
    if (!_textEditingControllers.containsKey(key)) {
      _textEditingControllers[key] = TextEditingController();
    }

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _textEditingControllers[key],
        decoration: InputDecoration(
          icon: Icon(icon),
          hintText: title,
          labelText: description,
        ),
        onChanged: (String value) {
          _answers.change(key, value);
        },
      ),
    );
  }

  onStepContinue() {
    if (_index < (stepList().length - 1)) {
      _index += 1;
    } else {
      print("Submitted");
      sendData();
    }
  }

  onStepCancel() {
    _index = 0;
    for (var value in _textEditingControllers.values) value.clear();
    _answers = Answers();
  }

  onStepTapped(int index) {
    _index = index;
  }

  int get index => _index;

  bool last() {
    return _index == stepList().length - 1;
  }

  set context(BuildContext value) {
    _context = value;
    _answers.context = value;
  }

  Future<String> defaultFunction() async {
    return "";
  }
}
