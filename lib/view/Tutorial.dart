import 'package:createstructure/viewmodel/TutorialViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:stacked/stacked.dart';

class Tutorial extends StatefulWidget {
  //MyTutorialPage({Key key, this.title}) : super(key: key);

  final String title = "test";

  @override
  _TutorialState createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TutorialViewModel>.reactive(
      builder: (context, viewModel, child) {
        return Scaffold(
          /*appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.tutorial),
            leading: Icon(Icons.book),
          ),*/
          body: IntroductionScreen(
            pages: viewModel.getPages(context),
            done: Text(AppLocalizations.of(context)!.done),
            onDone: () {
              print(AppLocalizations.of(context)!.done);
            },
            next: Icon(Icons.arrow_forward),
            showNextButton: true,
            showDoneButton: true,
            isTopSafeArea: true,
            isBottomSafeArea: true,
          ),
        );
      },
      viewModelBuilder: () => TutorialViewModel(),
      onModelReady: (viewModel) async {},
    );
  }
}
