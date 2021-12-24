import 'dart:io';

import 'package:createstructure/view/NoNetwork.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NetworkCheck {
  BuildContext _context;

  NetworkCheck(this._context);

  void checkNetwork() async {
    if (!(await checkIfNetwork())) {
      Navigator.push(
          _context, MaterialPageRoute(builder: (context) => NoNetwork()));
    }
  }

  void checkAgainNetwork() async {
    if (await checkIfNetwork()) {
      Navigator.pop(_context);
    }
  }

  Future<bool> checkIfNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) return true;
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
