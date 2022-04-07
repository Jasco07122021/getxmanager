import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxmanager/controllers/home_controller.dart';
import 'package:getxmanager/models/card_model.dart';
import '../../main.dart';
import 'dart:math' as math;

showLanguageBottomSheet(HomeController homeControllerGetX) {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        children: [
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "assets/images/img_england.png",
              ),
            ),
            title: const Text("English"),
            onTap: () {
              homeControllerGetX.changeLanguage("en", "US");
              Get.back();
            },
          ),
          ListTile(
            leading: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("assets/images/img_russian.png")),
            title: const Text("Russian"),
            onTap: () {
              homeControllerGetX.changeLanguage("ru", "RU");
              Get.back();
            },
          ),
          ListTile(
            leading: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("assets/images/img_uzb.png")),
            title: const Text("Uzbek"),
            onTap: () {
              homeControllerGetX.changeLanguage("uz", "UZ");
              Get.back();
            },
          ),
        ],
      ),
    ),
    backgroundColor:
        MyApp.appData.read("darkMode") ? Colors.grey.shade900 : Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
  );
}

showBrightnessBottomSheet() {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.brightness_2_outlined),
            title: const Text("Dark Mode"),
            onTap: () {
              MyApp.appData.write("darkMode", true);
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.wb_sunny_outlined),
            title: const Text("Light Mode"),
            onTap: () {
              MyApp.appData.write("darkMode", false);
              Get.back();
            },
          ),
        ],
      ),
    ),
    backgroundColor:
        MyApp.appData.read("darkMode") ? Colors.grey.shade900 : Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
  );
}

PopupMenuItem showPopMenuItem({image, text, value}) {
  return PopupMenuItem(
    child: Row(
      children: [
        Image.asset(
          image,
          height: 20,
          width: 20,
        ),
        const SizedBox(width: 10),
        Text(text),
      ],
    ),
    value: value,
  );
}

class CardAddHomePage extends StatelessWidget {
  final HomeController homeController;

  const CardAddHomePage({Key? key, required this.homeController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () async {
          homeController.addFilterPage();
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

class CardHomePage extends StatelessWidget {
  final HomeController homeController;
  final CardModel card;

  const CardHomePage(
      {Key? key, required this.homeController, required this.card})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                homeController.getHttpResponse();
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
                homeController.deleteCard(card);
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
                    homeController.editFilterPage(card);
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
}
