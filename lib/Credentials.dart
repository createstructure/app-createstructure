import 'package:createstructure/viewmodel/CredentialsViewModel.dart';
import 'package:end_credits/end_credits.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
              title: Text(AppLocalizations.of(context)!.credentials),
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
                Section(
                    title: AppLocalizations.of(context)!.developers,
                    roles: [
                      Role(
                          name: AppLocalizations.of(context)!.appDevelopers,
                          crew: [
                            Responsable(
                                AppLocalizations.of(context)!.castellanidavide)
                          ]),
                      Role(
                          name: AppLocalizations.of(context)!.coreDevelopers,
                          crew: [
                            Responsable(
                                AppLocalizations.of(context)!.castellanidavide)
                          ]),
                    ]),
                Section(
                    title: AppLocalizations.of(context)!.dependencies,
                    roles: [
                      Role(
                          name: AppLocalizations.of(context)!.appDependencies,
                          crew: [
                            Responsable(AppLocalizations.of(context)!.flutter),
                          ]),
                      Role(
                          name:
                              AppLocalizations.of(context)!.flutterDependencies,
                          crew: [
                            Responsable(
                                AppLocalizations.of(context)!.settings_ui),
                            Responsable(
                                AppLocalizations.of(context)!.stacked_services),
                            Responsable(AppLocalizations.of(context)!.stacked),
                            Responsable(AppLocalizations.of(context)!.http),
                            Responsable(AppLocalizations.of(context)!
                                .shared_preferences),
                            Responsable(
                                AppLocalizations.of(context)!.cupertino_icons),
                            Responsable(AppLocalizations.of(context)!
                                .flutter_launcher_icons),
                            Responsable(
                                AppLocalizations.of(context)!.end_credits),
                            Responsable(AppLocalizations.of(context)!
                                .flutter_native_splash),
                            Responsable(
                                AppLocalizations.of(context)!.fluttertoast),
                            Responsable(
                                AppLocalizations.of(context)!.url_launcher),
                          ]),
                    ]),
                Section(title: AppLocalizations.of(context)!.toolsUsed, roles: [
                  Role(
                      name: AppLocalizations.of(context)!.createApplication,
                      crew: [
                        Responsable(AppLocalizations.of(context)!.androidStudio)
                      ]),
                  Role(
                      name: AppLocalizations.of(context)!.storeApplication,
                      crew: [
                        Responsable(AppLocalizations.of(context)!.git),
                        Responsable(AppLocalizations.of(context)!.github),
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
