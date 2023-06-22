/// Settings View Model
///
/// @author @DavideC03
import 'package:createstructure/model/Account.dart';
import 'package:createstructure/model/SettingsData.dart';
import 'package:createstructure/model/SettingsType.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class SettingsViewModel extends MultipleFutureViewModel {
  static const DEFAULT_FUNCTION = "DEFAULT_FUNCTION";
  final _formKey = GlobalKey<FormState>();
  SettingsData _settingsData = new SettingsData();
  Account _account = Account();

  get username => _settingsData.username;
  get token => _settingsData.token;

  void init() async {
    /**
     * Get the account data from the shared preferences
     */
    await _settingsData.loadData();
  }

  @override
  Map<String, Future Function()> get futuresMap =>
      {DEFAULT_FUNCTION: defaultFunction};

  void change(BuildContext context, String title, SettingsType settingsType) {
    /**
     * Change the settings data
     *
     * @param context The context of the widget
     * @param title The title of the settings
     * @param settingsType The type of the settings
     */
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

  void _setLocate(String s, BuildContext context) async {
    /**
     * Set the language of the app
     *
     * @param s The language
     * @param context The context of the widget
     */
    var prefs = await SharedPreferences.getInstance();
    if (s == "")
      await prefs.remove('language_code');
    else
      await prefs.setString('language_code', s);
    await prefs.setBool('refresh', true);
    Phoenix.rebirth(context);
  }

  void changeAccount(BuildContext context) async {
    /**
     * Change the account data
     *
     * @param context The context of the widget
     */
    _account.context = context;
    _account.changeAccount();
  }

  void changeLanguage(BuildContext context) {
    /**
     * Change the language of the app
     *
     * @param context The context of the widget
     */
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _getLanguages(context),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  List<Widget> _getLanguages(BuildContext context) {
    /**
     * Get the languages of the app
     *
     * @param context The context of the widget
     * @return The languages of the app
     */
    return [
      _getLanguage(
        context: context,
        icon: Icon(Icons.phone_android),
        language: AppLocalizations.of(context)!.languages_default,
      ),
      _getLanguage(
        context: context,
        icon: Icon(Icons.language),
        language: AppLocalizations.of(context)!.en,
        languageCode: "en",
      ),
      _getLanguage(
        context: context,
        icon: Icon(Icons.language),
        language: AppLocalizations.of(context)!.it,
        languageCode: "it",
      ),
    ];
  }

  Widget _getLanguage({
    required BuildContext context,
    required Icon icon,
    String languageCode = "",
    required String language,
  }) {
    /**
     * Get the language of the app
     *
     * @param context The context of the widget
     * @param icon The icon of the language
     * @param languageCode The language code
     * @param language The language
     * @return The language of the app
     */
    return TextButton(
      onPressed: () {
        _setLocate(languageCode, context);
        Navigator.of(context).pop();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [icon],
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Text(language),
            ],
          )
        ],
      ),
    );
  }

  Future<String> defaultFunction() async {
    return "";
  }
}
