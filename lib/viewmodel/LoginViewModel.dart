/// Login View Model
///
/// @author @DavideC03
import 'package:createstructure/view/AutoLogin.dart';
import 'package:createstructure/view/ManualLogin.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends MultipleFutureViewModel {
  static const DEFAULT_FUNCTION = "DEFAULT_FUNCTION";
  BuildContext? _context;

  void autoLogin() {
    /**
     * This function will be called when the user clicks on the auto login button
     */
    print("Auto Login");
    Navigator.push(
        _context!, MaterialPageRoute(builder: (context) => AutoLogin()));
  }

  void manualLogin() {
    /**
     * This function will be called when the user clicks on the manual login button
     */
    print("Manual Login");
    Navigator.push(
        _context!, MaterialPageRoute(builder: (context) => ManualLogin()));
  }

  set context(BuildContext value) {
    _context = value;
  }

  @override
  Map<String, Future Function()> get futuresMap =>
      {DEFAULT_FUNCTION: defaultFunction};

  Future<String> defaultFunction() async {
    return "";
  }
}
