import 'package:createstructure/model/SettingsData.dart';
import 'package:createstructure/model/SettingsType.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class SettingsViewModel extends MultipleFutureViewModel {
  static const DEFAULT_FUNCTION = "DEFAULT_FUNCTION";
  final _formKey = GlobalKey<FormState>();
  SettingsData _settingsData = new SettingsData();

  get username => _settingsData.username;
  get token => _settingsData.token;

  init() async {
    await _settingsData.loadData();
  }

  @override
  Map<String, Future Function()> get futuresMap =>
      {DEFAULT_FUNCTION: defaultFunction};

  change(BuildContext context, String title, SettingsType settingsType) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Stack(
            //overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  )),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(title),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: AppLocalizations.of(context)!.insert_long,
                            labelText: AppLocalizations.of(context)!.insert),
                        onChanged: (String value) {
                          switch (settingsType) {
                            case SettingsType.USERNAME:
                              _settingsData.username = value;
                              break;
                            case SettingsType.TOKEN:
                              _settingsData.token = value;
                              break;
                            default:
                              break;
                          }
                          _settingsData.saveData();
                        },
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(AppLocalizations.of(context)!.save))
                  ],
                ),
              )
            ],
          ));
        });
  }

  _setLocate(String s, BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    if (s == "")
      await prefs.remove('language_code');
    else
      await prefs.setString('language_code', s);
    await prefs.setBool('refresh', true);
    Phoenix.rebirth(context);
  }

  changeUsername(BuildContext context) async {
    change(context, AppLocalizations.of(context)!.change_username,
        SettingsType.USERNAME);
  }

  changeToken(BuildContext context) {
    change(context, AppLocalizations.of(context)!.change_token,
        SettingsType.TOKEN);
  }

  changeLanguage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              //overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                    right: -40.0,
                    top: -40.0,
                    child: InkResponse(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: CircleAvatar(
                        child: Icon(Icons.close),
                        backgroundColor: Colors.red,
                      ),
                    )),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          _setLocate("", context);
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.phone_android),
                              ],
                            ),
                            Text("\t\t\t"),
                            Column(
                              children: [
                                Text(AppLocalizations.of(context)!
                                    .languages_default),
                              ],
                            )
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _setLocate("en", context);
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.language),
                              ],
                            ),
                            Text("\t\t\t"),
                            Column(
                              children: [
                                Text(AppLocalizations.of(context)!.en),
                              ],
                            )
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _setLocate("it", context);
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.language),
                              ],
                            ),
                            Text("\t\t\t"),
                            Column(
                              children: [
                                Text(AppLocalizations.of(context)!.it),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<String> defaultFunction() async {
    return "";
  }
}
