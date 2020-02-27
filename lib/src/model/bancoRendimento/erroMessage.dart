class ErroMessage {
  int statusCode;
  String message;
  List<dynamic> errors;

  ErroMessage({
    this.statusCode,
    this.message,
    this.errors,
  });

  factory ErroMessage.fromJson(Map<String, dynamic> json) => ErroMessage(
    statusCode: json["statusCode"],
    message: json["message"],
    errors: List<dynamic>.from(json["errors"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "errors": List<dynamic>.from(errors.map((x) => x)),
  };
}