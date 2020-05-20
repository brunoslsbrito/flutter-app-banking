class FetchPaymentsByDateDTO {
  String merchant;
  int status;
  String dateStart;
  String dateEnd;

  FetchPaymentsByDateDTO(
      String merchant, int status, String dateStart, String dateEnd) {
    this.merchant = merchant;
    this.status = status;
    this.dateStart = dateStart;
    this.dateEnd = dateEnd;
  }

  Map<String, dynamic> toJson() => {
        "merchant": merchant,
        "status": status,
        "dateStart": dateStart,
        "dateEnd": dateEnd,
      };
}
