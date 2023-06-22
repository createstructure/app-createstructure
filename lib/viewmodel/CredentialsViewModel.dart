/// Credentials View Model
///
/// @author @DavideC03
import 'package:stacked/stacked.dart';

class CredentialsViewModel extends MultipleFutureViewModel {
  static const DEFAULT_FUNCTION = "DEFAULT_FUNCTION";

  @override
  Map<String, Future Function()> get futuresMap =>
      {DEFAULT_FUNCTION: defaultFunction};

  Future<String> defaultFunction() async {
    return "";
  }
}
