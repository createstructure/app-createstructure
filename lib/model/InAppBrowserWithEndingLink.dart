/**
  * Inside app browser window
  *
  * @author @DavideC03
 */
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppBrowserWithEndingLink extends InAppBrowser {
  String _endLink = "";
  Function()? _onClose;
  InAppBrowserWithEndingLink({
    String endLink = "",
    Function()? onClose,
  }) {
    _endLink = endLink;
    _onClose = onClose;
  }

  @override
  Future onLoadStart(url) async {
    /**
      * If the url is the ending link, close the browser
      */
    if (url.toString() == _endLink) {
      close();
    }
  }

  @override
  void onExit() {
    /**
      * If the browser is closed, call the onClose function
      */
    _onClose!();
  }
}
