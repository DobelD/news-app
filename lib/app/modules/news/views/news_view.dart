import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

import 'package:get/get.dart';

import '../controllers/news_controller.dart';

class NewsView extends GetView<NewsController> {
  const NewsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String link = Get.arguments;
    return Scaffold(
        body: SafeArea(
      child: WillPopScope(
        onWillPop: () => controller.onBack(),
        child: Scaffold(
          body: SafeArea(
              child: WebView(
            initialUrl: link,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              controller.webctrl.complete(webViewController);
            },

            javascriptChannels: <JavascriptChannel>{
              _toasterJavascriptChannel(context),
            },

            gestureNavigationEnabled: true,
            geolocationEnabled: false, //support geolocation or not
          )),
        ),
      ),
    ));
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: avoid_print
          print(message);
        });
  }
}
