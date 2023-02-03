import 'dart:async';

import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  final Completer<WebViewController> webctrl = Completer<WebViewController>();
  onBack() async {
    var canGoBack =
        await webctrl.future.then((controller) => controller.canGoBack());
    if (canGoBack) {
      // If the webview can go back, go back
      webctrl.future.then((controller) => controller.goBack());
      return false;
    }
    // If the webview cannot go back, close the app
    return true;
  }
}
