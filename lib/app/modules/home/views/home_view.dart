import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:newsapps/app/routes/app_pages.dart';
import 'package:newsapps/styles/app_color.dart';
import 'package:newsapps/styles/app_typo.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (context) {
      return DefaultTabController(
          initialIndex: 0,
          length: controller.listCategori.length,
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: AppColor.secondaryColor,
                title: Text('News', style: AppTypo.heading1),
                bottom: TabBar(
                    labelPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: controller.listCategori
                        .map((e) => Tab(text: e))
                        .toList()),
              ),
              body: TabBarView(
                  children: controller.listCategori.map((kategori) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GetBuilder<HomeController>(builder: (ctx) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.listNews.length,
                              itemBuilder: (context, index) {
                                var news = controller.listNews[index];
                                if (controller.listNews[index].category ==
                                    kategori) {
                                  return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: GestureDetector(
                                        onTap: () => Get.toNamed(Routes.NEWS,
                                            arguments: news.url),
                                        child: SizedBox(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${news.name}",
                                              style: AppTypo.highlight2,
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "${news.description}",
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTypo.content,
                                            ),
                                            const SizedBox(height: 12),
                                            Divider(
                                              color: AppColor.disableColor,
                                              height: 0,
                                              thickness: 1.1,
                                            )
                                          ],
                                        )),
                                      ));
                                } else {
                                  return const SizedBox();
                                }
                              });
                        })
                      ],
                    ),
                  ),
                );
              }).toList())));
    });
  }
}
