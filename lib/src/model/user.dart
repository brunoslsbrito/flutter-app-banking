class User {
  final String name;
  final String email;
  final String lastname;
  final String login ;

  User({this.name, this.email, this.lastname, this.login});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['entity']['name'],
      email: json['entity']['email'],
      lastname: json['entity']['lastname'],
      login: json['entity']['login'],
    );
  }
}
