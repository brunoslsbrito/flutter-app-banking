import 'package:flexpay/src/model/bancoRendimento/value.dart';

import 'erroMessage.dart';

class ResponseBillInfo {
  Value value;
  ErroMessage erroMessage;
  bool isSucess;
  bool isFailure;

  ResponseBillInfo({
    this.value,
    this.erroMessage,
    this.isSucess,
    this.isFailure,
  });

  factory ResponseBillInfo.fromJson(Map<String, dynamic> json) =>
      ResponseBillInfo(
        value: json['value'] != null ? Value.fromJson(json["value"]) : null,
        erroMessage: json["erroMessage"] != null ? ErroMessage.fromJson(json["erroMessage"]) : null,
        isSucess: json["isSucess"],
        isFailure: json["isFailure"],
      );

  Map<String, dynamic> toJson() => {
        "value": value.toJson(),
        "erroMessage": erroMessage.toJson(),
        "isSucess": isSucess,
        "isFailure": isFailure,
      };
}
