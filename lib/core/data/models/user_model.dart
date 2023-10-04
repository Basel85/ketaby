class UserModel {
  final int id;
  final String name;
  final String email;
  final String? address;
  final String? city;
  final String? phone;
  final bool emailVerified;
  final String image;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.address,
      required this.city,
      required this.phone,
      required this.emailVerified,
      required this.image});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        address: json['address'] ?? "No Address",
        city: json['city']?? "No City",
        phone: json['phone']?? "No Phone",
        emailVerified: json['email_verified'],
        image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "address": address,
      "city": city,
      "phone": phone,
      "email_verified": emailVerified,
      "image": image
    };
  }
}
