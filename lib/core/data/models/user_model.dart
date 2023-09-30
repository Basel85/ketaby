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
        address: json['address'],
        city: json['city'],
        phone: json['phone'],
        emailVerified: json['email_verified'],
        image: json['image']);
  }
  
  Map<String,dynamic> toJson({required UserModel user}) {
    return {
      "id": user.id,
      "name": user.name,
      "email": user.email,
      "address": user.address,
      "city": user.city,
      "phone": user.phone,
      "email_verified": user.emailVerified,
      "image": user.image
    };
  }
}
