/// Auto Login View Model
///
/// @author @DavideC03
import 'dart:convert';

import 'package:createstructure/model/Account.dart';
import 'package:createstructure/model/InAppBrowserWithEndingLink.dart';
import 'package:createstructure/model/SettingsData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';
import 'package:synchronized/synchronized.dart';

class AutoLoginViewModel extends MultipleFutureViewModel {
  static const DEFAULT_FUNCTION = "DEFAULT_FUNCTION";
  static const String _CLIENT_ID = "4586020fd298fe1d5e8c";
  static const String _SCOPE = Account.PERMISSION;
  static const String _GRANT_TYPE =
      "urn:ietf:params:oauth:grant-type:device_code";
  static const String _LINK_GET_CODE = "https://github.com/login/device/code";
  static const String _LINK_INSERT_CODE = "https://github.com/login/device";
  static const String _LINK_GET_TOKEN =
      "https://github.com/login/oauth/access_token";
  static const String _LINK_END = "https://github.com/login/device/success";
  String? _deviceCode;
  String _userCode = "";
  SettingsData _settingsData = SettingsData();
  var _lockGetCode = new Lock();
  bool _gotCode = false;
  bool _loaded = false;
  BuildContext? _context;
  InAppBrowserWithEndingLink? _inAppBrowserWithEndingLink;
  InAppBrowserClassOptions _appBrowserClassOptions = InAppBrowserClassOptions(
    crossPlatform: InAppBrowserOptions(
      hideUrlBar: true,
      hideToolbarTop: true,
    ),
    inAppWebViewGroupOptions: InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        javaScriptEnabled: true,
      ),
    ),
  );

  Future<void> getCode() async {
    /**
     * Get the device code
     */
    await _lockGetCode.synchronized(_getCode);
  }

  Future<void> _getCode() async {
    /**
     * Get the device code, private method
     */
    if (_gotCode) return;
    _gotCode = true;
    try {
      String body = json.encode({
        "client_id": _CLIENT_ID,
        "scope": _SCOPE,
      });

      print("Body: $body");

      var r = await http.post(
        Uri.parse(_LINK_GET_CODE),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: body,
      );
      var response = json.decode(r.body);
      print(response.toString());

      _deviceCode = response["device_code"];
      _userCode = response["user_code"];

      Clipboard.setData(ClipboardData(text: _userCode));
    } catch (_) {
      print("Error getCode: " + _.toString());
    }
  }

  Future<void> getToken() async {
    /**
     * Get the token
     */
    try {
      String body = json.encode({
        "client_id": _CLIENT_ID,
        "device_code": _deviceCode,
        "grant_type": _GRANT_TYPE,
      });

      var r = await http.post(Uri.parse(_LINK_GET_TOKEN),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: body);
      var response = json.decode(r.body);
      print(response.toString());

      _settingsData.token = response["access_token"];
      _settingsData.username = await _getUsername();
      _settingsData.saveDataContext(_context!);
    } catch (_) {
      print("Error getToken: " + _.toString());
    }
  }

  Future<String> _getUsername() async {
    /**
     * Get the username
     *
     * @return String username
     */
    try {
      var r = await http.post(
        Uri.parse("https://api.github.com/user"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "token " + _settingsData.token,
        },
      );

      var response = json.decode(r.body);
      print(response.toString());

      return response["login"];
    } catch (_) {
      return "";
    }
  }

  void onOpenBrowser() async {
    /**
     * Open the browser
     */
    try {
      await _inAppBrowserWithEndingLink!.openUrlRequest(
        urlRequest: URLRequest(url: Uri.parse(_LINK_INSERT_CODE)),
        options: _appBrowserClassOptions,
      );
    } catch (_) {
      print("Browser error: " + _.toString());
    }
  }

  String get userCode => _userCode;

  bool get loaded {
    bool tmp = _loaded;
    _loaded = true;
    return tmp;
  }

  set context(BuildContext value) {
    _context = value;
    _settingsData.loadData();
    _inAppBrowserWithEndingLink = InAppBrowserWithEndingLink(
      endLink: _LINK_END,
      onClose: () async {
        await getToken();
      },
    );
  }

  @override
  Map<String, Future Function()> get futuresMap =>
      {DEFAULT_FUNCTION: defaultFunction};

  Future<String> defaultFunction() async {
    return "";
  }
}
