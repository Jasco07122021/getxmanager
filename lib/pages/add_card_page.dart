import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxmanager/controllers/add_card_controller.dart';

class AddCardPage extends StatelessWidget {
  AddCardPage({Key? key}) : super(key: key);

  final addCardController = Get.put(AddCardController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Get.theme.brightness == Brightness.dark
              ? Colors.transparent
              : Colors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Add your card".tr,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                ///top place
                Expanded(
                  child: Container(
                    color: Get.theme.brightness == Brightness.dark
                        ? Colors.transparent
                        : Colors.blue,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          "Fill in the fields  below or use camera phone".tr,
                          style:
                              TextStyle(color: Theme.of(context).canvasColor),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "Your card number".tr,
                          style:
                              TextStyle(color: Theme.of(context).canvasColor),
                        ),
                        const SizedBox(height: 10),
                        _addCardNumber(),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            expiryDateAndCvv2(
                              context,
                              "Expiry date",
                              Row(
                                children: [
                                  _textFieldEntryDate(
                                    controller:
                                        addCardController.entryDateController,
                                    mask: addCardController
                                        .entryDateMaskFormatter.value,
                                  ),
                                  const VerticalDivider(color: Colors.black),
                                  _textFieldEntryDate(
                                    controller:
                                        addCardController.entryYearController,
                                    mask: addCardController
                                        .entryYearMaskFormatter.value,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 25),
                            expiryDateAndCvv2(
                              context,
                              "CVV2",
                              TextField(
                                controller: addCardController.cvv2Controller,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  addCardController.cvv2MaskFormatter.value
                                ],
                                style: const TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  hintText: "000",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                ///save button
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(bottom: 30),
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 50),
                      onPressed: () {
                        if (addCardController.cardOld == null) {
                          addCardController.save().then((value) {
                            if (value == true) {
                              Get.back(result: true);
                            }
                          });
                        } else {
                          addCardController.editCard().then((value) {
                            if (value == true) {
                              Get.back(result: false);
                            }
                          });
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text("Save".tr),
                      textColor: Colors.white,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),

            ///text field
            Center(
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: TextField(
                  controller: addCardController.cardNameController,
                  style: const TextStyle(color: Colors.black),
                  decoration: decorationField(name: "Name".tr),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded expiryDateAndCvv2(BuildContext context, String text, Widget child) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text.tr,
            style: TextStyle(color: Theme.of(context).canvasColor),
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: child,
          ),
        ],
      ),
    );
  }

  Expanded _textFieldEntryDate({controller, mask}) {
    return Expanded(
      child: TextField(
        keyboardType: TextInputType.number,
        controller: controller,
        inputFormatters: [mask],
        style: const TextStyle(color: Colors.black),
        textAlign: TextAlign.center,
        decoration: decorationField(name: "00"),
      ),
    );
  }

  InputDecoration decorationField({name}) {
    return InputDecoration(
      hintText: name,
      hintStyle: const TextStyle(color: Colors.grey),
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
    );
  }

  Container _addCardNumber() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Image.asset(
                "assets/images/img_2.png",
                height: 30,
              )),
          Expanded(
            flex: 8,
            child: TextField(
              controller: addCardController.cardNumberController,
              inputFormatters: [
                addCardController.cardNumberMaskFormatter.value
              ],
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black),
              decoration: decorationField(name: "Card number"),
            ),
          ),
        ],
      ),
    );
  }
}
