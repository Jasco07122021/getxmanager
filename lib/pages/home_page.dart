import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxmanager/controllers/home_controller.dart';
import 'package:getxmanager/controllers/translator_controller.dart';
import 'package:getxmanager/main.dart';
import 'package:logger/logger.dart';

import '../models/card_model.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final homeControllerGetX = Get.put(HomeController());
  final translatorController = Get.put(TranslatorController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text("GetX"),
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                switch (value) {
                  case 1:
                    translatorController.changeLanguage("uz", "UZ");
                    break;
                  case 2:
                    translatorController.changeLanguage("ru", "RU");
                    break;
                  case 3:
                    translatorController.changeLanguage("en", "US");
                    break;
                  case 4:
                  case 5:
                    Logger().i("aa");
                    // Get.changeThemeMode(
                    //     Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                    Get.isDarkMode
                        ? MyApp.appData.write("darkMode", false)
                        : MyApp.appData.write("darkMode", true);

                    break;
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(child: Text("Uzbek"), value: 1),
                PopupMenuItem(
                  child: Text("Russian"),
                  value: 2,
                ),
                PopupMenuItem(
                  child: Text("England"),
                  value: 3,
                ),
                PopupMenuItem(
                  child: Text("Dark"),
                  value: 4,
                ),
                PopupMenuItem(
                  child: Text("Light"),
                  value: 5,
                ),
              ],
            ),
          ],
        ),
        body: homeControllerGetX.isLoading()
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 10),
                  Column(
                    children: homeControllerGetX.list
                        .map((CardModel e) => _card(e))
                        .toList(),
                  ),
                  _cardAdd(),
                ],
              ),
      ),
    );
  }

  Dismissible _card(CardModel card) {
    return Dismissible(
      onDismissed: (direction) {
        Get.defaultDialog(
          title: "Delete Card".tr,
          content: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text("Do you want to delete your card?".tr),
          ),
          cancel: TextButton(
              onPressed: () {
                homeControllerGetX.getHttpResponse();
                Get.back();
              },
              child: Text(
                "Cancel".tr,
                style: const TextStyle(color: Colors.red),
              )),
          confirm: TextButton(
              onPressed: () {
                Get.back();
                Get.snackbar("Message",
                    "Hi Anvar! Your card is successfully deleted.".tr);
                homeControllerGetX.deleteCard(card);
              },
              child: Text("Confirm".tr)),
          contentPadding:
              const EdgeInsets.only(top: 5, bottom: 10, left: 20, right: 20),
        );
      },
      movementDuration: const Duration(seconds: 2),
      key: GlobalKey(),
      background: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.red)),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        child: GestureDetector(
          onTap: () {
            Get.defaultDialog(
              title: "Edit Card".tr,
              content: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text("Do you want to change your card?".tr),
              ),
              cancel: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Cancel".tr,
                    style: const TextStyle(color: Colors.red),
                  )),
              confirm: TextButton(
                  onPressed: () {
                    homeControllerGetX.editFilterPage(card);
                  },
                  child: Text("Confirm".tr)),
              contentPadding: const EdgeInsets.only(
                  top: 5, bottom: 10, left: 20, right: 20),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0),
            ),
            height: 230,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/img.png"),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Text(
                    card.cardNumber,
                    style: const TextStyle(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Card holder".tr,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            card.cardName,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Expires".tr,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            "${card.expDate}/${card.expYear}",
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _cardAdd() {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () async {
          homeControllerGetX.addFilterPage();
        },
        child: Container(
          height: 230,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/img_3.png",
                height: 50,
              ),
              const SizedBox(height: 20),
              Text(
                "Add new card".tr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
