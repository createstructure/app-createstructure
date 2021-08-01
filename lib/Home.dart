import 'package:createstructure/Credentials.dart';
import 'package:createstructure/Settings.dart';
import 'package:createstructure/model/Answers.dart';
import 'package:createstructure/viewmodel/HomeViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

class Home extends StatefulWidget {
  //MyHomePage({Key key, this.title}) : super(key: key);

  final String title = "test";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  Answers _answers = new Answers();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, viewModel, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.createstructure),
              leading: Icon(Icons.home),
              actions: <Widget>[
                /*Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: IconButton(
                    icon: Icon(Icons.source_outlined),
                    onPressed: () => launch(
                        "https://github.com/createstructure/app-createstructure"),
                  ),
                ),*/
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Credentials()));
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
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
                child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.format_quote),
                          hintText: AppLocalizations.of(context)!.q1short,
                          labelText: AppLocalizations.of(context)!.q1long),
                      onChanged: (String value) {
                        _answers.name = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.copy),
                          hintText: AppLocalizations.of(context)!.q2short,
                          labelText: AppLocalizations.of(context)!.q2long),
                      onChanged: (String value) {
                        _answers.template = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.description),
                          hintText: AppLocalizations.of(context)!.q3short,
                          labelText: AppLocalizations.of(context)!.q3long),
                      onChanged: (String value) {
                        _answers.descr = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.navigate_before),
                          hintText: AppLocalizations.of(context)!.q4short,
                          labelText: AppLocalizations.of(context)!.q4long),
                      onChanged: (String value) {
                        _answers.prefix = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.business),
                          hintText: AppLocalizations.of(context)!.q5short,
                          labelText: AppLocalizations.of(context)!.q5long),
                      onChanged: (String value) {
                        _answers.org = value;
                        _answers.isOrg = value != null && value != "";
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.group),
                          hintText: AppLocalizations.of(context)!.q6short,
                          labelText: AppLocalizations.of(context)!.q6long),
                      onChanged: (String value) {
                        _answers.team = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.public),
                          hintText: AppLocalizations.of(context)!.q7short,
                          labelText: AppLocalizations.of(context)!.q7long),
                      onChanged: (String value) {
                        _answers.private =
                            !(["N", "No", "n", "no"].contains(value));
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          _formKey.currentState?.reset();
                        },
                        child: Text(AppLocalizations.of(context)!.reset),
                      ),
                      TextButton(
                        onPressed: () {
                          viewModel.sendData(_answers, context);
                        },
                        child: Text(AppLocalizations.of(context)!.create),
                      ),
                    ],
                  ),
                ],
              ),
            )));
      },
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (viewModel) async {},
    );
  }
}
