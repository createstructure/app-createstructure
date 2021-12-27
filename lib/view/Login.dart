/**
  * Login page
  *
  * @author @DavideC03
 */
import 'package:createstructure/viewmodel/LoginViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    /**
     * Login page
     *
     * @param context The context of the page
     * @return Widget The page
     */
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, viewModel, child) {
        viewModel.context = context;
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.login_title),
              leading: Icon(Icons.login),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "assets/images/login.png",
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  AppLocalizations.of(context)!.login_pre,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: () =>
                      launch("https://github.com/marketplace/createstructure"),
                  child: Text(AppLocalizations.of(context)!.subscribe),
                ),
                Text(
                  AppLocalizations.of(context)!.login_description,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: () => viewModel.autoLogin(),
                  child: Text(AppLocalizations.of(context)!.login_auto),
                ),
                TextButton(
                  onPressed: () => viewModel.manualLogin(),
                  child: Text(AppLocalizations.of(context)!.login_manual),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (viewModel) async {},
    );
  }
}
