class CardModel {
  late String id;
  late String cardNumber;
  late String expDate;
  late String expYear;
  late String cvv2;
  late String cardName;

  CardModel({
    required this.id,
    required this.cardNumber,
    required this.expDate,
    required this.expYear,
    required this.cvv2,
    required this.cardName,
  });

  CardModel.fromJson(Map<dynamic, dynamic> json)
      : id = json["id"],
        cardNumber = json["cardNumber"],
        expDate = json["expDate"],
        expYear = json["expYear"],
        cvv2 = json['cvv2'],
        cardName = json['cardName'];

  Map<dynamic, dynamic> toJson() => {
        'cardNumber': cardNumber,
        'expDate': expDate,
        'expYear': expYear,
        'cvv2': cvv2,
        'cardName': cardName,
      };
}
