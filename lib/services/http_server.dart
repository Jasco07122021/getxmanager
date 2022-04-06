import 'dart:convert';
import 'package:http/http.dart';

import '../models/card_model.dart';

class HttpServer {
  ///API domain + header
  static String DOMAIN = "6209f5a392946600171c566d.mockapi.io";

  ///API posts
  static String API_LIST = "/api/card";
  static String API_POST = "/api/card";
  static String API_PUT = "/api/card/";
  static String API_DELETE = "/api/card/";

  ///API methods
  static Future<String?> GET(String api, Map<String, String> params) async {
    var url = Uri.https(DOMAIN, api, params);
    Response response = await get(url);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    var url = Uri.https(DOMAIN, api);
    Response response = await post(url, body: params);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    var url = Uri.https(DOMAIN, api);
    Response response = await put(url, body: params);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DELETE(String api) async {
    var url = Uri.https(DOMAIN, api);
    Response response = await delete(url);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  ///API functions
  static Map<String, String> paramsEmpty() {
    Map<String, String> map = {};
    return map;
  }

  static Map<String, String> paramsCard(
      {cardNumber, expDate, expYear, cvv2, cardName}) {
    Map<String, String> map = {
      "cardNumber": cardNumber,
      "expDate": expDate,
      "expYear": expYear,
      "cvv2": cvv2,
      "cardName": cardName
    };
    return map;
  }

  static CardModel parseResponse(String response) {
    Map<String, String> map = jsonDecode(response) ?? {};
    CardModel card = CardModel.fromJson(map);
    return card;
  }

  static List<CardModel> parseCardResponse(String response) {
    List json = jsonDecode(response);
    List<CardModel> cards =
        List<CardModel>.from(json.map((x) => CardModel.fromJson(x)));
    return cards;
  }
}
