import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TranslatorGetX extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        "en_US": {
          //add card page
          'Add your card': "Add your card",
          'Fill in the fields  below or use camera phone':
              "Fill in the fields  below or use camera phone",
          'Your card number': "Your card number",
          'Expiry date': "Expiry date",
          'CVV2': "CVV2",
          'Name': "Name",
          'Save': "Save",
          //home page
          "Add new card": "Add new card",
          "Expires": "Expires",
          "Card holder": "Card holder",
          "Delete Card":"Delete Card",
          "Edit Card":"Edit Card",
          "Do you want to delete your card?":"Do you want to delete your card?",
          "Do you want to change your card?":"Do you want to change your card?",
          "Cancel":"Cancel",
          "Confirm":"Confirm",
          "Hi Anvar! Your card is successfully changed.":"Hi Anvar! Your card is successfully changed.",
        },
        "ru_RU": {
          //add card page
          'Add your card': "Добавьте свою карту",
          'Fill in the fields  below or use camera phone':
              "Заполните поля ниже или используйте телефон с камерой",
          'Your card number': "Номер вашей карты",
          'Expiry date': "Срок действия",
          'CVV2': "CVV2",
          'Name': "Имя",
          'Save': "Сохранить",
          //home page
          "Add new card": "Добавить новую карту",
          "Expires": "Срок",
          "Card holder": "Держатель карты",
          "Delete Card":"Удалить карту",
          "Edit Card":"Редактировать карту",
          "Do you want to delete your card?":"Вы хотите удалить свою карту?",
          "Do you want to change your card?":"Вы хотите сменить свою карту?",
          "Cancel":"Отмена",
          "Confirm":"Подтвердить",
          "Hi Anvar! Your card is successfully changed.":"Привет, Анвар! Ваша карта успешно заменена.",
        },
        "uz_UZ": {
          //add card page
          'Add your card': "Karta qo'shish",
          'Fill in the fields  below or use camera phone':
              "Quyidagilarni to'ldiring yoki telefon kamerasidan foydalaning",
          'Your card number': "Sizning karta raqamingiz",
          'Expiry date': "Foydalanish muddat",
          'CVV2': "CVV2",
          'Name': "Ism",
          'Save': "Saqlamoq",
          //home page
          "Add new card": "Yangi karta qo'shing",
          "Expires": "Muddat",
          "Card holder": "Karta egasi",
          "Delete Card":"Kartani O'chirish",
          "Edit Card":"Kartani Tahrirlash",
          "Do you want to delete your card?":"Kartangizni o'chirishni istaysizmi?",
          "Do you want to change your card?":"Kartangizni o'zgartirmoqchimisiz?",
          "Cancel":"Bekor Qilish",
          "Confirm":"Tasdiqlash",
          "Hi Anvar! Your card is successfully changed.":"Salom Anvar! Sizning karta muvaffaqiyatli o'zgartirildi.",
        }
      };
}

class TranslatorController extends GetxController {
  changeLanguage(var value1, var value2) {
    var locale = Locale(value1, value2);
    Get.updateLocale(locale);
  }
}
