import 'package:createstructure/viewmodel/SettingsViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                  title: "Identification",
                  titlePadding: EdgeInsets.all(20),
                  tiles: [
                    SettingsTile(
                      title: "Username",
                      subtitle: viewModel.username,
                      leading: Icon(Icons.person),
                      onPressed: viewModel.changeUsername,
                    ),
                    SettingsTile(
                      title: "Token",
                      subtitle: viewModel.token,
                      leading: Icon(Icons.password),
                      onPressed: viewModel.changeToken,
                    ),
                    SettingsTile(
                      title: "Subscribe",
                      subtitle: "Press here to open the subscription page.",
                      leading: Icon(Icons.monetization_on),
                      onPressed: (BuildContext context) {
                        launch(
                            "https://github.com/marketplace/createstructure");
                      },
                    ),
                    SettingsTile(
                      title: "Refresh",
                      subtitle: "Press here to refresh info.",
                      leading: Icon(Icons.refresh),
                      onPressed: (BuildContext context) {
                        setState(() {});
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
        //textEditingController.text = await viewModel.getDevice();
      },
    );
  }
}
