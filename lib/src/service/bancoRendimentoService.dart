import 'dart:convert';

import 'package:FlexPay/src/model/bancoRendimento/responseBillInfo.dart';
import 'package:FlexPay/src/util/consts.dart';
import 'package:http/http.dart';

class BancoRendimentoService {

  Future<ResponseBillInfo> loadBillInfos(String barcode) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
    };
    final String URL =  Consts.HOST_BANCO_RENDIMENTO + 'pagamento/info-boleto';
    String body = '{"codigoBarras": "", "linhaDigitavel": "10499593883700010004200000713180981900000091588","numeroDocumento": "","dataVencimento": ""}';
    Response response = await post(URL, headers: headers, body: body);

    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return ResponseBillInfo.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Ops! Aconteceu algum problema');
    }
  }
}
