

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxmanager/controllers/home_controller.dart';
import 'package:getxmanager/widgets/home_page_widgets.dart';

import '../models/card_model.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final homeControllerGetX = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>
          Scaffold(
            appBar: AppBar(
              title: const Text("GetX"),
              actions: [
                PopupMenuButton(
                  onSelected: (value) {
                    switch (value) {
                      case 1:
                        showLanguageBottomSheet(homeControllerGetX);
                        break;
                      case 2:
                        showBrightnessBottomSheet();
                        break;
                    }
                  },
                  itemBuilder: (context) =>
                  [
                    showPopMenuItem(
                      image: "assets/images/img_language.png",
                      text: "Language",
                      value: 1,
                    ),
                    showPopMenuItem(
                      image: "assets/images/img_sun.png",
                      text: "Brightness",
                      value: 2,
                    ),
                  ],
                ),
              ],
            ),
            body: homeControllerGetX.isLoading()
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : Obx(
                  () =>
                  ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(height: 10),
                      Column(
                        children: homeControllerGetX.list
                            .map((CardModel e) =>
                            CardHomePage(homeController: homeControllerGetX,card: e))
                            .toList(),
                      ),
                      CardAddHomePage(homeController: homeControllerGetX),
                    ],
                  ),
            ),
          ),
    );
  }

}
