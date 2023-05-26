class booking {
  final String itemNama;
  final String itemHari;

  booking({required this.itemNama, required this.itemHari});

  Map<String, dynamic> toJson() {
    return {"nama": itemNama, "hari": itemHari};
  }

  factory booking.fromJson(Map<String, dynamic> json) {
    return booking(itemNama: json['nama'], itemHari: json['hari']);
  }
}
