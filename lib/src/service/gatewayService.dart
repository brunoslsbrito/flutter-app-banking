import 'dart:convert';

import 'package:FlexPay/src/model/dto/gateway/fetchPaymentsByDateDTO.dart';
import 'package:FlexPay/src/model/dto/gateway/paymentGatewayDTO.dart';
import 'package:FlexPay/src/util/consts.dart';
import 'package:http/http.dart';

class GatewayService {
  Future<PaymentGatewayDTO> fetchPayment() async {
    Map<String, String> headers = {"Content-type": "application/json"};
    final String uri = Consts.HOST_ERP_PAYMENT_BACKEND + 'payment/fetch';
    var payload = new FetchPaymentsByDateDTO("", 2, '2020-05-01', '2020-05-20');

    String body =
        '{"merchant": "1ab41be0-fb97-46a4-b1b0-df5b851f247d", "dateStart": "2020-05-01", "dateEnd": "2020-05-21", "status": [0,1,2]}';

    Response response = await post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return parseTransaction(response.body);
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Ops! Aconteceu algum problema');
    }
  }

  PaymentGatewayDTO parseTransaction(String responseBody) {
    return PaymentGatewayDTO.fromJson(json.decode(responseBody));
  }
}
