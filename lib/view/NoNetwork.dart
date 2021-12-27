/**
  * No Network page
  *
  * @author @DavideC03
 */
import 'package:createstructure/viewmodel/NoNetworkViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

class NoNetwork extends StatefulWidget {
  @override
  _NoNetworkState createState() => _NoNetworkState();
}

class _NoNetworkState extends State<NoNetwork> {
  @override
  Widget build(BuildContext context) {
    /**
     * No Network page
     *
     * @param context The context of the page
     * @return Widget The page
     */
    return ViewModelBuilder<NoNetworkViewModel>.reactive(
      builder: (context, viewModel, child) {
        viewModel.context = context;
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.network_error_title),
              leading: Icon(Icons.network_wifi_outlined),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "assets/images/networkError.png",
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  AppLocalizations.of(context)!.network_error_description,
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: viewModel.check,
                  child:
                      Text(AppLocalizations.of(context)!.network_error_button),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => NoNetworkViewModel(),
      onModelReady: (viewModel) async {},
    );
  }
}
