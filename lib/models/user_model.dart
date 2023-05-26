class UserModel {
  String image;
  String uid;
  String? email;
  String firstName;
  String lastName;
  String? name;
  num phone;

  UserModel(
      {this.image = '',
      this.uid = '',
      this.email,
      this.firstName = '',
      this.lastName = '',
      this.name,
      this.phone = 0});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      image: map['image'],
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      phone: map['phone'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      image: json['image'],
      uid: json['uid'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
    };
  }

  UserModel copy({
    String? imagePath,
  }) =>
      UserModel(
        image: imagePath ?? image,
      );
}
