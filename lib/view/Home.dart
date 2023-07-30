/// Home page
///
/// @author @DavideC03
import 'package:createstructure/view/Credits.dart';
import 'package:createstructure/view/Settings.dart';
import 'package:createstructure/viewmodel/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Home extends StatefulWidget {
  //MyHomePage({Key key, this.title}) : super(key: key);

  final String title = "test";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    /**
     * Home page
     *
     * @param context The context of the page
     * @return Widget The page
     */
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, viewModel, child) {
        viewModel.context = context;
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.createstructure),
            leading: Icon(Icons.home),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: Image.asset(
                    "assets/images/GitHub.png",
                    height: 24,
                    width: 24,
                  ),
                  onPressed: () => launchUrlString("https://createstructure.github.io/"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Credentials()));
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  },
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Stepper(
              type: StepperType.vertical,
              currentStep: viewModel.index,
              steps: viewModel.stepList(),
              onStepContinue: () => setState(() {
                viewModel.onStepContinue();
              }),
              onStepCancel: () => setState(() {
                viewModel.onStepCancel();
              }),
              onStepTapped: (int index) => setState(() {
                viewModel.onStepTapped(index);
              }),
              controlsBuilder: (BuildContext context2,
              ControlsDetails controlsDetails) {
                return Row(
                  children: [
                    TextButton(
                      onPressed: controlsDetails.onStepContinue,
                      child: Text(viewModel.last()
                          ? AppLocalizations.of(context)!.submit
                          : AppLocalizations.of(context)!.continue_),
                    ),
                    TextButton(
                      onPressed: controlsDetails.onStepCancel,
                      child: Text(AppLocalizations.of(context)!.reset),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
