class PaymentDTO {
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
  PaymentDTO(
      {this.amount,
      this.uid,
      this.installments,
      this.cardNumber,
      this.cardHolder,
      this.nsuCode,
      this.authorizationCode,
      this.receivedAt,
      this.cardId,
      this.status});

  PaymentDTO.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    uid = json['uid'];
    installments = json['installments'];
    cardNumber = json['cardNumber'];
    cardHolder = json['cardHolder'];
    nsuCode = json['nsuCode'];
    authorizationCode = json['authorizationCode'];
    receivedAt = json['receivedAt'];
    cardId = json['cardId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['uid'] = this.uid;
    data['installments'] = this.installments;
    data['cardNumber'] = this.cardNumber;
    data['cardHolder'] = this.cardHolder;
    data['nsuCode'] = this.nsuCode;
    data['authorizationCode'] = this.authorizationCode;
    data['receivedAt'] = this.receivedAt;
    data['cardId'] = this.cardId;
    data['status'] = this.status;
    return data;
  }
}
