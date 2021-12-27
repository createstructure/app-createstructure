/**
  * Manual Login page
  *
  * @author @DavideC03
 */
import 'package:createstructure/viewmodel/ManualLoginViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

class ManualLogin extends StatefulWidget {
  @override
  _ManualLoginState createState() => _ManualLoginState();
}

class _ManualLoginState extends State<ManualLogin> {
  @override
  Widget build(BuildContext context) {
    /**
     * Manual Login page
     *
     * @param context The context of the page
     * @return Widget The page
     */
    return ViewModelBuilder<ManualLoginViewModel>.reactive(
      builder: (context, viewModel, child) {
        viewModel.context = context;

        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.login_manual),
            leading: Icon(Icons.login),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "assets/images/manualLogin.png",
                  //fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  AppLocalizations.of(context)!.login_manual_description,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText:
                          AppLocalizations.of(context)!.login_get_username,
                    ),
                    controller: viewModel.controllerUsername,
                    onChanged: viewModel.setUsername,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.login_get_token,
                    ),
                    controller: viewModel.controllerToken,
                    onChanged: viewModel.setToken,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: viewModel.submit,
                  child: Text(AppLocalizations.of(context)!.login_title),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => ManualLoginViewModel(),
      onModelReady: (viewModel) async {},
    );
  }
}
