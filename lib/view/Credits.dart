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
                    crew: const [
                      Responsable("cherry_toast"),
                      Responsable("cupertino_icons"),
                      Responsable("end_credits"),
                      Responsable("flutter_inappwebview"),
                      Responsable("flutter_launcher_icons"),
                      Responsable("flutter_native_splash"),
                      Responsable("fluttertoast"),
                      Responsable("http"),
                      Responsable("introduction_screen"),
                      Responsable("settings_ui"),
                      Responsable("shared_preferences"),
                      Responsable("stacked"),
                      Responsable("stacked_services"),
                      Responsable("synchronized"),
                      Responsable("url_launcher"),
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
