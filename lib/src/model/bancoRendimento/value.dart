class Value {
  String cnpjcpfBeneficiario;
  String cnpjcpfPagador;
  String codigoDeBarras;
  double desconto;
  double juros;
  String linhaDigitavel;
  String motivo;
  double multa;
  String nomeBeneficiario;
  String nomePagador;
  bool permiteAlterarValorTotal;
  bool permitePagamentoParcial;
  String razaoSocialBeneficiario;
  int tipoAutorizacaoRecebimentoValorDivergente;
  int tipoPagamentoDiverso;
  bool validarDuplicidade;
  double valor;
  double valorMaximo;
  double valorMinimo;
  double valorTotal;
  DateTime dataVencimento;
  DateTime dataLimitePagamento;
  bool habilitaMp;
  DateTime dataHoraConsultaBoleto;

  Value({
    this.cnpjcpfBeneficiario,
    this.cnpjcpfPagador,
    this.codigoDeBarras,
    this.desconto,
    this.juros,
    this.linhaDigitavel,
    this.motivo,
    this.multa,
    this.nomeBeneficiario,
    this.nomePagador,
    this.permiteAlterarValorTotal,
    this.permitePagamentoParcial,
    this.razaoSocialBeneficiario,
    this.tipoAutorizacaoRecebimentoValorDivergente,
    this.tipoPagamentoDiverso,
    this.validarDuplicidade,
    this.valor,
    this.valorMaximo,
    this.valorMinimo,
    this.valorTotal,
    this.dataVencimento,
    this.dataLimitePagamento,
    this.habilitaMp,
    this.dataHoraConsultaBoleto,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        cnpjcpfBeneficiario: json["cnpjcpfBeneficiario"],
        cnpjcpfPagador: json["cnpjcpfPagador"],
        codigoDeBarras: json["codigoDeBarras"],
        desconto: json["desconto"],
        juros: json["juros"],
        linhaDigitavel: json["linhaDigitavel"],
        motivo: json["motivo"],
        multa: json["multa"],
        nomeBeneficiario: json["nomeBeneficiario"],
        nomePagador: json["nomePagador"],
        permiteAlterarValorTotal: json["permiteAlterarValorTotal"],
        permitePagamentoParcial: json["permitePagamentoParcial"],
        razaoSocialBeneficiario: json["razaoSocialBeneficiario"],
        tipoAutorizacaoRecebimentoValorDivergente:
            json["tipoAutorizacaoRecebimentoValorDivergente"],
        tipoPagamentoDiverso: json["tipoPagamentoDiverso"],
        validarDuplicidade: json["validarDuplicidade"],
        valor: json["valor"].toDouble(),
        valorMaximo: json["valorMaximo"],
        valorMinimo: json["valorMinimo"],
        valorTotal: json["valorTotal"].toDouble(),
        dataVencimento: DateTime.parse(json["dataVencimento"]),
        dataLimitePagamento: json["dataLimitePagamento"] != null ?  DateTime.parse(json["dataLimitePagamento"]) : null,
        habilitaMp: json["habilitaMP"],
        dataHoraConsultaBoleto: DateTime.parse(json["dataHoraConsultaBoleto"]),
      );

  Map<String, dynamic> toJson() => {
        "cnpjcpfBeneficiario": cnpjcpfBeneficiario,
        "cnpjcpfPagador": cnpjcpfPagador,
        "codigoDeBarras": codigoDeBarras,
        "desconto": desconto,
        "juros": juros,
        "linhaDigitavel": linhaDigitavel,
        "motivo": motivo,
        "multa": multa,
        "nomeBeneficiario": nomeBeneficiario,
        "nomePagador": nomePagador,
        "permiteAlterarValorTotal": permiteAlterarValorTotal,
        "permitePagamentoParcial": permitePagamentoParcial,
        "razaoSocialBeneficiario": razaoSocialBeneficiario,
        "tipoAutorizacaoRecebimentoValorDivergente":
            tipoAutorizacaoRecebimentoValorDivergente,
        "tipoPagamentoDiverso": tipoPagamentoDiverso,
        "validarDuplicidade": validarDuplicidade,
        "valor": valor,
        "valorMaximo": valorMaximo,
        "valorMinimo": valorMinimo,
        "valorTotal": valorTotal,
        "dataVencimento": dataVencimento.toIso8601String(),
        "dataLimitePagamento": dataLimitePagamento.toIso8601String(),
        "habilitaMP": habilitaMp,
        "dataHoraConsultaBoleto": dataHoraConsultaBoleto.toIso8601String(),
      };
}
