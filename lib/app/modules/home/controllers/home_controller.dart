import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:newsapps/app/data/news_model.dart';

class HomeController extends GetxController {
  List<String> listCategori = [];
  List<News> listNews = [];
  List<Map<String, String>> sources = [];

  getCategory() async {
    String apiKey = '42f20b17a8e74a508b59b7c819f05110';
    var respons = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines/sources?apiKey=$apiKey'));

    try {
      if (respons.statusCode == 200) {
        var data = json.decode(respons.body);
        List<String> categories = [];
        for (var item in data['sources']) {
          categories.add(item['category']);
        }

        listCategori = categories.toSet().toList();
        List<dynamic> list = (json.decode(respons.body)['sources']);
        listNews = list.map((e) => News.fromJson(e)).toList();

        update();
        // ignore: avoid_print
        print(sources);
      } else {
        // ignore: avoid_print
        print('gagal');
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCategory();
  }
}
