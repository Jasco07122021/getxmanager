import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxmanager/models/card_model.dart';
import 'package:logger/logger.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../services/http_server.dart';

class AddCardController extends GetxController {
  CardModel? cardOld = Get.arguments;

  @override
  void onInit() {
    if (cardOld != null) {
      cardNumberController.text = cardOld!.cardNumber;
      entryDateController.text = cardOld!.expDate;
      entryYearController.text = cardOld!.expYear;
      cvv2Controller.text = cardOld!.cvv2;
      cardNameController.text = cardOld!.cardName;
    }
    super.onInit();
  }

  @override
  void onClose() {
    cardNumberController.dispose();
    cardNameController.dispose();
    entryYearController.dispose();
    entryDateController.dispose();
    cvv2Controller.dispose();
    super.onClose();
  }

  var cardNumberController = TextEditingController();
  var cardNumberMaskFormatter = MaskTextInputFormatter(
      mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')}).obs;

  var entryDateController = TextEditingController();
  var entryDateMaskFormatter =
      MaskTextInputFormatter(mask: '##', filter: {"#": RegExp(r'[0-9]')}).obs;
  var entryYearController = TextEditingController();
  var entryYearMaskFormatter =
      MaskTextInputFormatter(mask: '##', filter: {"#": RegExp(r'[0-9]')}).obs;

  var cvv2Controller = TextEditingController();
  var cvv2MaskFormatter =
      MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')}).obs;

  var cardNameController = TextEditingController();

  Future<bool> save() async {
    check();
    String? value = await HttpServer.POST(
        HttpServer.API_POST,
        HttpServer.paramsCard(
          expDate: entryDateController.value.text,
          cardName: cardNameController.value.text,
          cardNumber: cardNumberController.value.text,
          cvv2: cvv2Controller.value.text,
          expYear: entryYearController.value.text,
        ));
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> editCard() async {
    Logger().i("edit");
    check();
    Logger().i("edit2");
    String? value = await HttpServer.PUT(
      HttpServer.API_PUT + cardOld!.id,
      HttpServer.paramsCard(
        expDate: entryDateController.value.text,
        cardName: cardNameController.value.text,
        cardNumber: cardNumberController.value.text,
        cvv2: cvv2Controller.value.text,
        expYear: entryYearController.value.text,
      ),
    );
    Logger().i(value);
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  check() {
    String expDate = entryDateController.value.text;
    String cardNumber = cardNumberController.value.text;
    String expYear = entryYearController.value.text;
    String cvv2 = cvv2Controller.value.text;
    String cardName = cardNameController.value.text;
    if (expDate.length != 2 ||
        expYear.length != 2 ||
        cardNumber.length != 19 ||
        expDate.isEmpty ||
        cardNumber.isEmpty ||
        expYear.isEmpty ||
        cvv2.isEmpty ||
        cardName.isEmpty) {
      return false;
    }
  }
}
