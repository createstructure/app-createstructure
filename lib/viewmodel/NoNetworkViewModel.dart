/// No Network View Model
///
/// @author @DavideC03
import 'package:createstructure/model/NetworkCheck.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class NoNetworkViewModel extends MultipleFutureViewModel {
  static const DEFAULT_FUNCTION = "DEFAULT_FUNCTION";
  NetworkCheck? _networkCheck;
  BuildContext? _context;

  set context(BuildContext value) {
    _context = value;
    _networkCheck = NetworkCheck(_context!);
  }

  void check() {
    /**
     * Check if the device has internet connection
     */
    _networkCheck!.checkAgainNetwork();
  }

  @override
  Map<String, Future Function()> get futuresMap =>
      {DEFAULT_FUNCTION: defaultFunction};

  Future<String> defaultFunction() async {
    return "";
  }
}
