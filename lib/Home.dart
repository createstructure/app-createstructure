import 'package:createstructure/Credentials.dart';
import 'package:createstructure/Settings.dart';
import 'package:createstructure/model/Answers.dart';
import 'package:createstructure/viewmodel/HomeViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              title: Text("createstructure"),
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
                      decoration: const InputDecoration(
                          icon: Icon(Icons.format_quote),
                          hintText: "Name of the project",
                          labelText: "Insert the name of the project:"),
                      onChanged: (String value) {
                        _answers.name = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          icon: Icon(Icons.copy),
                          hintText: "Name of the template",
                          labelText: "Insert the name of the template:"),
                      onChanged: (String value) {
                        _answers.template = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          icon: Icon(Icons.description),
                          hintText: "Description",
                          labelText: "Insert the description:"),
                      onChanged: (String value) {
                        _answers.descr = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          icon: Icon(Icons.navigate_before),
                          hintText: "Prefix",
                          labelText: "Insert the prefix (if you want once):"),
                      onChanged: (String value) {
                        _answers.prefix = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          icon: Icon(Icons.business),
                          hintText: "Organization name",
                          labelText:
                              "Insert the Organization name (if you want to put the new project there):"),
                      onChanged: (String value) {
                        _answers.org = value;
                        _answers.isOrg = value != null && value != "";
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          icon: Icon(Icons.group),
                          hintText: "Organization team",
                          labelText:
                              "Insert the team (if you use Organization):"),
                      onChanged: (String value) {
                        _answers.team = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          icon: Icon(Icons.public),
                          hintText: "Private",
                          labelText:
                              "Insert if you want to create a private repo [Y/n]:"),
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
                          _formKey.currentState.reset();
                        },
                        child: Text("Reset"),
                      ),
                      TextButton(
                        onPressed: () {
                          viewModel.sendData(_answers);
                        },
                        child: Text("Create"),
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
