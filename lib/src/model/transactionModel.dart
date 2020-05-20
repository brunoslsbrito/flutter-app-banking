class TransactionModel {
  int status;
  String uid;
  int amount;
  String cardNumber;
  double totalValue;
  String description;
  int installments;
  String receivedAt;
  String nsuCode;
  String authorizationCode;
  String cardHolder;
  String merchantOrderId;
  int cardId;
  bool selected;

  TransactionModel(
      {this.amount,
      this.description,
      this.installments,
      this.receivedAt,
      this.nsuCode,
      this.authorizationCode,
      this.cardHolder,
      this.cardNumber,
      this.status,
      this.merchantOrderId,
      this.cardId,
      this.uid,
      this.selected});

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
        amount: json['amount'],
        installments: json['installments'],
        nsuCode: json['nsuCode'],
        authorizationCode: json['authorizationCode'],
        cardHolder: json['cardHolder'],
        cardNumber: json['cardNumber'],
        status: json['status'],
        uid: json['uid'],
        selected: false);
  }

}
