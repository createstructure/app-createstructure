/// Settings page
///
/// @author @DavideC03
import 'package:createstructure/model/SettingsData.dart';
import 'package:createstructure/viewmodel/SettingsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    /**
     * Settings page
     *
     * @param context The context of the page
     * @return Widget The page
     */
    return ViewModelBuilder<SettingsViewModel>.reactive(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Settings"),
            leading: Icon(Icons.settings),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Icon(Icons.home),
                ),
              )
            ],
          ),
          body: SettingsList(
            sections: [
              SettingsSection(
                title: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(AppLocalizations.of(context)!.identification),
                ),
                tiles: [
                  SettingsTile(
                    title: Text(AppLocalizations.of(context)!.login_as),
                    description: viewModel.username,
                    leading: Icon(Icons.person),
                    onPressed: viewModel.changeAccount,
                  ),
                  /*SettingsTile(
                    title: AppLocalizations.of(context)!.token,
                    subtitle: viewModel.token,
                    leading: Icon(Icons.password),
                    onPressed: viewModel.changeToken,
                  ),*/
                  SettingsTile(
                    title: Text(AppLocalizations.of(context)!.subscribe),
                    description:
                        Text(AppLocalizations.of(context)!.subscribe_long),
                    leading: Icon(Icons.monetization_on),
                    onPressed: (BuildContext context) {
                      launchUrlString("https://github.com/marketplace/createstructure");
                    },
                  ),
                  SettingsTile(
                    title: Text(AppLocalizations.of(context)!.refresh),
                    description:
                        Text(AppLocalizations.of(context)!.refresh_long),
                    leading: Icon(Icons.refresh),
                    onPressed: (BuildContext context) {
                      setState(() {});
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(AppLocalizations.of(context)!.languages),
                ),
                tiles: [
                  SettingsTile(
                    title: Text(AppLocalizations.of(context)!.languages),
                    description: Text(AppLocalizations.of(context)!.languages_long),
                    leading: Icon(Icons.language),
                    onPressed: (BuildContext context) {
                      viewModel.changeLanguage(context);
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(AppLocalizations.of(context)!.help),
                ),
                tiles: [
                  SettingsTile(
                    title: Text(AppLocalizations.of(context)!.tutorial),
                    description: Text(AppLocalizations.of(context)!.tutorial_long),
                    leading: Icon(Icons.help),
                    onPressed: (BuildContext context) async {
                      var prefs = await SharedPreferences.getInstance();
                      SettingsData settingsData = SettingsData();
                      await settingsData.loadData();
                      settingsData.tutorial = false;
                      print(settingsData);
                      await settingsData.saveData();
                      await prefs.setBool('refresh', true);
                      await Phoenix.rebirth(context);
                    },
                  ),
                  SettingsTile(
                    title: Text(AppLocalizations.of(context)!.ask),
                    description: Text(AppLocalizations.of(context)!.ask_long),
                    leading: Icon(Icons.help),
                    onPressed: (BuildContext context) => launchUrlString(
                        "https://github.com/createstructure/app-createstructure/discussions/new?category=q-a"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => SettingsViewModel(),
      onViewModelReady: (viewModel) async {
        viewModel.init();
      },
    );
  }
}
