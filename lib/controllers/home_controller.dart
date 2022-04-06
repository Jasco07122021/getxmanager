import 'package:get/get.dart';
import 'package:getxmanager/models/card_model.dart';

import '../pages/add_card_page.dart';
import '../services/http_server.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHttpResponse();
  }

  var showFloatActionButton = true.obs;

  var isLoading = false.obs;
  var list = <CardModel>[].obs;

  getHttpResponse() async {
    isLoading(true);

    await HttpServer.GET(HttpServer.API_LIST, HttpServer.paramsEmpty())
        .then((value) => _getUI(value));
  }

  _getUI(String? value) {
    if (value != null) {
      isLoading(false);
      list.clear();
      list.value = HttpServer.parseCardResponse(value);
    }
  }

  deleteCard(CardModel card) {
    list.remove(card);
    HttpServer.DELETE(HttpServer.API_DELETE + card.id);
  }

  addFilterPage() async {
    await Get.to(() => AddCardPage(), transition: Transition.cupertino)
        ?.then((value) {
      if (value != null) {
        Get.snackbar(
            "Message", "Hi Anvar! Your card is successfully added.".tr);
        getHttpResponse();
      }
    });
  }

  editFilterPage(CardModel card) async {
    await Get.to(()=> AddCardPage(), arguments: card)?.then((value) {
      Get.back();
      if (value != null) {
        Get.snackbar(
            "Message", "Hi Anvar! Your card is successfully changed.".tr);
        getHttpResponse();
      }
    });
  }
}
