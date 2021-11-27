import 'package:createstructure/viewmodel/SettingsViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
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
                  title: AppLocalizations.of(context)!.identification,
                  titlePadding: EdgeInsets.all(20),
                  tiles: [
                    SettingsTile(
                      title: AppLocalizations.of(context)!.username,
                      subtitle: viewModel.username,
                      leading: Icon(Icons.person),
                      onPressed: viewModel.changeUsername,
                    ),
                    SettingsTile(
                      title: AppLocalizations.of(context)!.token,
                      subtitle: viewModel.token,
                      leading: Icon(Icons.password),
                      onPressed: viewModel.changeToken,
                    ),
                    SettingsTile(
                      title: AppLocalizations.of(context)!.subscribe,
                      subtitle: AppLocalizations.of(context)!.subscribeLong,
                      leading: Icon(Icons.monetization_on),
                      onPressed: (BuildContext context) {
                        launch(
                            "https://github.com/marketplace/createstructure");
                      },
                    ),
                    SettingsTile(
                      title: AppLocalizations.of(context)!.refresh,
                      subtitle: AppLocalizations.of(context)!.refreshLong,
                      leading: Icon(Icons.refresh),
                      onPressed: (BuildContext context) {
                        setState(() {});
                      },
                    ),
                  ]),
              SettingsSection(
                  title: AppLocalizations.of(context)!.languages,
                  titlePadding: EdgeInsets.all(20),
                  tiles: [
                    SettingsTile(
                      title: AppLocalizations.of(context)!.languages,
                      subtitle: AppLocalizations.of(context)!.languagesLong,
                      leading: Icon(Icons.language),
                      onPressed: (BuildContext context) {
                        viewModel.changeLanguage(context);
                      },
                    ),
                  ]),
            ],
          ),
        );
      },
      viewModelBuilder: () => SettingsViewModel(),
      onModelReady: (viewModel) async {
        viewModel.init();
      },
    );
  }
}
