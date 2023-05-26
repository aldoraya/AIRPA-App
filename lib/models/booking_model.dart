class BookingModel {
  final String name;
  final String email;
  final num phone;
  final DateTime startDate;
  final DateTime endDate;

  BookingModel(
      {
      required this.name,
      required this.email,
      required this.phone,
      required this.startDate,
      required this.endDate});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "startDate": startDate,
      "endDate": endDate
    };
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      startDate: json['startDate'],
      endDate: json['endDate']
    );
  }

  factory BookingModel.fromMap(map) {
    return BookingModel(
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      startDate: map['startDate'],
      endDate: map['endDate']
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'startDate': startDate,
      'endDate': endDate
    };
  }
}
