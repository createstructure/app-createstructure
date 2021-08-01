import 'package:createstructure/model/SettingsData.dart';
import 'package:createstructure/model/SettingsType.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SettingsViewModel extends MultipleFutureViewModel {
  static const DEFAULT_FUNCTION = "DEFAULT_FUNCTION";
  final _formKey = GlobalKey<FormState>();
  SettingsData _settingsData;

  get username => _settingsData.username;
  get token => _settingsData.token;

  init() async {
    _settingsData = new SettingsData();
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
                        decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: "Insert here",
                            labelText: "Insert:"),
                        onChanged: (String value) {
                          switch (settingsType) {
                            case SettingsType.USERNAME:
                              _settingsData.username = value;
                              break;
                            case SettingsType.TOKEN:
                              _settingsData.token = value;
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
                        child: Text("Save"))
                  ],
                ),
              )
            ],
          ));
        });
  }

  changeUsername(BuildContext context) async {
    change(context, "Change Username", SettingsType.USERNAME);
  }

  changeToken(BuildContext context) {
    change(context, "Change Token", SettingsType.TOKEN);
  }

  Future<String> defaultFunction() async {
    return "";
  }
}
