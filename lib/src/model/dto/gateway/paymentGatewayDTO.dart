import 'package:FlexPay/src/model/dto/gateway/paymentDTO.dart';

class PaymentGatewayDTO {
  List<PaymentDTO> payments;
  String merchant;

  PaymentGatewayDTO({this.payments, this.merchant});

  PaymentGatewayDTO.fromJson(Map<String, dynamic> json) {
    if (json['payments'] != null) {
      payments = new List<PaymentDTO>();
      json['payments'].forEach((v) {
        payments.add(new PaymentDTO.fromJson(v));
      });
    }
    merchant = json['merchant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.payments != null) {
      data['payments'] = this.payments.map((v) => v.toJson()).toList();
    }
    data['merchant'] = this.merchant;
    return data;
  }
}
