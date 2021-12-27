/**
  * Check for the network connection
  *
  * @author @DavideC03
 */
import 'package:createstructure/view/NoNetwork.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:synchronized/synchronized.dart';

class NetworkCheck {
  BuildContext _context;
  bool _check = true;
  bool? _value;
  var _lock = new Lock();

  NetworkCheck(this._context);

  void checkNetwork() async {
    /**
     * Check if the network is available, if not, show the NoNetwork page
     */
    if (!(await checkIfNetwork())) {
      Navigator.push(
          _context, MaterialPageRoute(builder: (context) => NoNetwork()));
    }
  }

  void checkAgainNetwork() async {
    /**
     * Check if the network is become available
     */
    _check = true;
    if (await checkIfNetwork()) {
      Navigator.pop(_context);
    }
  }

  Future<void> _checkIfNetwork() async {
    /**
     * Check if the network is available, private method
     */
    if (_check) {
      _check = false;
      try {
        var r = await http.get(
          Uri.parse("https://example.com"),
        );
        if (r.statusCode == 200)
          _value = true;
        else
          _value = false;
      } catch (_) {
        _value = false;
      }
    }
    print("Network state: " + _value.toString());
  }

  Future<bool> checkIfNetwork() async {
    /**
     * Check if the network is available
     */
    await _lock.synchronized(_checkIfNetwork);

    return _value!;
  }
}
