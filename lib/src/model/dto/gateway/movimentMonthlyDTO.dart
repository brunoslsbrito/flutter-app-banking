class MovimentMonthlyDTO {
  List<String> _ref;
  List<double> _acumulado;

  MovimentMonthlyDTO({List<String> ref, List<double> acumulado}) {
    this._ref = ref;
    this._acumulado = acumulado;
  }

  List<String> get ref => _ref;

  set ref(List<String> ref) => _ref = ref;

  List<double> get acumulado => _acumulado;

  set acumulado(List<double> acumulado) => _acumulado = acumulado;

  MovimentMonthlyDTO.fromJson(Map<String, dynamic> json) {
    _ref = json['ref'].cast<String>();
    _acumulado = json['acumulado'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ref'] = this._ref;
    data['acumulado'] = this._acumulado;
    return data;
  }
}
