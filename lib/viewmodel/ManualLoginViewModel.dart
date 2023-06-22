/// MAnual Login View Model
///
/// @author @DavideC03
import 'package:createstructure/model/SettingsData.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class ManualLoginViewModel extends MultipleFutureViewModel {
  static const DEFAULT_FUNCTION = "DEFAULT_FUNCTION";
  BuildContext? _context;
  SettingsData _settingsData = SettingsData();
  TextEditingController _controllerUsername =
      new TextEditingController(text: '');
  TextEditingController _controllerToken = new TextEditingController(text: '');

  TextEditingController get controllerUsername => _controllerUsername;

  void setUsername(String username) {
    /**
      * Set the username
      *
      * @param username The username of the user
      */
    _settingsData.username = username;
  }

  void setToken(String token) {
    /**
      * Set the token
      *
      * @param token The token of the user
      */
    _settingsData.token = token;
  }

  void submit() async {
    /**
      * Submit the data
      */
    await _settingsData.saveDataContext(_context!);
  }

  Future<void> _loadData() async {
    /**
      * Load the data
      */
    await _settingsData.loadData();
    _controllerUsername.text = _settingsData.username;
    _controllerToken.text = _settingsData.token;
  }

  set context(BuildContext value) {
    _context = value;
    _loadData();
  }

  @override
  Map<String, Future Function()> get futuresMap =>
      {DEFAULT_FUNCTION: defaultFunction};

  Future<String> defaultFunction() async {
    return "";
  }

  TextEditingController get controllerToken => _controllerToken;
}
