import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
                elevation: 1,
                toolbarHeight: Get.height * 0.03,
                backgroundColor: Colors.white,
                title: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text('News',
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                ),
                bottom: TabBar(
                    isScrollable: true,
                    indicatorColor: AppColor.disableColor,
                    unselectedLabelColor: AppColor.disableColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    indicatorPadding: const EdgeInsets.only(bottom: 8),
                    indicator: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(25)),
                    tabs: controller.listCategori
                        .map((e) => Tab(
                              height: 32,
                              child: Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: Text(e.toUpperCase(),
                                      style: AppTypo.highlight3)),
                            ))
                        .toList()),
              ),
              body: TabBarView(
                  children: controller.listCategori.map((kategori) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
