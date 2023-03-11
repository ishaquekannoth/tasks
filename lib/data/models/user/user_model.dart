class UserModel {
  String phoneNumber;
  String password;
  String email;
  String city;
  String state;
  String? image;
  UserModel(
      {required this.phoneNumber,
      this.image,
      required this.password,
      required this.email,
      required this.city,
      required this.state});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        phoneNumber: json["phoneNumber"],
        password: json["password"],
        email: json["email"],
        city: json["city"],
        state: json["state"],
        image: json["image"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "phoneNumber": phoneNumber,
      "password": password,
      "email": email,
      "city": city,
      "state": state,
      "image": image
    };
  }

  List<String> toList() {
    return [email, password, phoneNumber, city, state];
  }

  @override
  String toString() {
    return "$email $password $phoneNumber $city $state";
  }
}
