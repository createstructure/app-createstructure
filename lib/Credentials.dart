import 'package:createstructure/viewmodel/CredentialsViewModel.dart';
import 'package:end_credits/end_credits.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Credentials extends StatefulWidget {
  final String title = "test";

  @override
  _CredentialsState createState() => _CredentialsState();
}

class _CredentialsState extends State<Credentials> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CredentialsViewModel>.reactive(
      builder: (context, viewModel, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text("Credentials"),
              leading: Icon(Icons.info),
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
            body: EndCredits(
              [
                Section(title: "Developers", roles: [
                  Role(
                      name: "App developers",
                      crew: [Responsable("Castellani Davide")]),
                  Role(
                      name: "Core developers",
                      crew: [Responsable("Castellani Davide")]),
                ]),
                Section(title: "Dependencies", roles: [
                  Role(name: "App dependencies", crew: [
                    Responsable("Flutter"),
                  ]),
                  Role(name: "Flutter dependencies", crew: [
                    Responsable("settings_ui"),
                    Responsable("stacked_services"),
                    Responsable("stacked"),
                    Responsable("http"),
                    Responsable("shared_preferences"),
                    Responsable("cupertino_icons"),
                    Responsable("flutter_launcher_icons"),
                    Responsable("end_credits"),
                    Responsable("flutter_native_splash"),
                    Responsable("fluttertoast"),
                    Responsable("url_launcher"),
                  ]),
                ]),
                Section(title: "Tools used", roles: [
                  Role(
                      name: "Create application",
                      crew: [Responsable("Android Studio")]),
                  Role(name: "Store application source", crew: [
                    Responsable("git"),
                    Responsable("GitHub"),
                  ]),
                ]),
              ],
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(
                fontSize: 50.0,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              roleTextStyle: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
              responsableTextStyle: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w900,
              ),
              delay: Duration(milliseconds: 0),
              speedFactor: normalSpeedFactor,
            ));
      },
      viewModelBuilder: () => CredentialsViewModel(),
      onModelReady: (viewModel) async {},
    );
  }
}
