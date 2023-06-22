/// Credentials page
///
/// @author @DavideC03
import 'package:createstructure/viewmodel/CredentialsViewModel.dart';
import 'package:end_credits/end_credits.dart';
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
    /**
     * Credentials page
     *
     * @param context The context of the page
     * @return Widget The page
     */
    return ViewModelBuilder<CredentialsViewModel>.reactive(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.credits),
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
                    name: AppLocalizations.of(context)!.app_developers,
                    crew: [
                      Responsable(
                          AppLocalizations.of(context)!.castellani_davide)
                    ],
                  ),
                  Role(
                    name: AppLocalizations.of(context)!.core_developers,
                    crew: [
                      Responsable(
                          AppLocalizations.of(context)!.castellani_davide)
                    ],
                  ),
                ],
              ),
              Section(
                title: AppLocalizations.of(context)!.dependencies,
                roles: [
                  Role(
                    name: AppLocalizations.of(context)!.appDependencies,
                    crew: [
                      Responsable(AppLocalizations.of(context)!.flutter),
                    ],
                  ),
                  Role(
                    name: AppLocalizations.of(context)!.flutter_dependencies,
                    crew: [
                      Responsable(AppLocalizations.of(context)!.settings_ui),
                      Responsable(
                          AppLocalizations.of(context)!.stacked_services),
                      Responsable(AppLocalizations.of(context)!.stacked),
                      Responsable(AppLocalizations.of(context)!.http),
                      Responsable(
                          AppLocalizations.of(context)!.shared_preferences),
                      Responsable(
                          AppLocalizations.of(context)!.cupertino_icons),
                      Responsable(
                          AppLocalizations.of(context)!.flutter_launcher_icons),
                      Responsable(AppLocalizations.of(context)!.end_credits),
                      Responsable(
                          AppLocalizations.of(context)!.flutter_native_splash),
                      Responsable(AppLocalizations.of(context)!.fluttertoast),
                      Responsable(
                          AppLocalizations.of(context)!.introduction_screen),
                      Responsable(AppLocalizations.of(context)!.url_launcher),
                      Responsable(
                          AppLocalizations.of(context)!.flutter_inappwebview),
                      Responsable(AppLocalizations.of(context)!.synchronized),
                    ],
                  ),
                ],
              ),
              Section(
                title: AppLocalizations.of(context)!.tools_used,
                roles: [
                  Role(
                    name: AppLocalizations.of(context)!.create_application,
                    crew: [
                      Responsable(AppLocalizations.of(context)!.android_studio)
                    ],
                  ),
                  Role(
                    name: AppLocalizations.of(context)!.store_application,
                    crew: [
                      Responsable(AppLocalizations.of(context)!.git),
                      Responsable(AppLocalizations.of(context)!.github),
                    ],
                  ),
                ],
              ),
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
            speedFactor: fastSpeedFactor,
          ),
        );
      },
      viewModelBuilder: () => CredentialsViewModel(),
    );
  }
}
