/**
  * Template page
  *
  * @author @DavideC03
 */
import 'package:createstructure/viewmodel/TemplateViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class Template extends StatefulWidget {
  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  @override
  Widget build(BuildContext context) {
    /**
     * Template page
     *
     * @param context The context of the page
     * @return Widget The page
     */
    return ViewModelBuilder<TemplateViewModel>.reactive(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.createstructure),
            leading: Icon(Icons.info),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: Image.asset(
                    "assets/images/GitHub.png",
                    height: 24,
                    width: 24,
                  ),
                  onPressed: () => launch("https://createstructure.github.io/"),
                ),
              ),
            ],
          ),
          body: Text("Template"),
        );
      },
      viewModelBuilder: () => TemplateViewModel(),
      onModelReady: (viewModel) async {},
    );
  }
}
