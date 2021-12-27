/**
  * AutoLogin page
  *
  * @author @DavideC03
 */
import 'package:createstructure/viewmodel/AutoLoginViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

class AutoLogin extends StatefulWidget {
  @override
  _AutoLoginState createState() => _AutoLoginState();
}

class _AutoLoginState extends State<AutoLogin> {
  @override
  Widget build(BuildContext context) {
    /**
     * Build the AutoLogin page
     *
     * @param context the context of the app
     * @return the AutoLogin page
     */
    return ViewModelBuilder<AutoLoginViewModel>.reactive(
      builder: (context, viewModel, child) {
        viewModel.context = context;
        viewModel.getCode().then((_) async {
          if (!viewModel.loaded)
            setState(() {
              print("Code created: " + viewModel.userCode);
            });
        });
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.login_auto),
            leading: Icon(Icons.login),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                "assets/images/autoLogin.png",
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.login_auto_description,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: viewModel.onOpenBrowser,
                child: Text(AppLocalizations.of(context)!.login_title),
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => AutoLoginViewModel(),
      onModelReady: (viewModel) async {},
    );
  }
}
