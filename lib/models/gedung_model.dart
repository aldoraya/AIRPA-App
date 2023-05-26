class GedungModel {
  final String? titleTxt;
  final String? subTxt;
  final String? desc1;
  final String? desc2;
  final num? perDay;
  final String? location;

  GedungModel(
      {
      this.titleTxt,
      this.subTxt,
      this.desc1,
      this.desc2,
      this.perDay,
      this.location});

  Map<String, dynamic> toJson() {
    return {
      "titleTxt": titleTxt,
      "subTxt": subTxt,
      "desc1": desc1,
      "desc2": desc2,
      "perDay": perDay,
      "location": location,
    };
  }

  factory GedungModel.fromJson(Map<String, dynamic> json) {
    return GedungModel(
      titleTxt: json['titleTxt'],
      subTxt: json['subTxt'],
      desc1: json['desc1'],
      desc2: json['desc2'],
      perDay: json['perDay'],
      location: json['location'],
    );
  }

  factory GedungModel.fromMap(map) {
    return GedungModel(
      titleTxt: map['titleTxt'],
      subTxt: map['subTxt'],
      desc1: map['desc1'],
      desc2: map['desc2'],
      perDay: map['perDay'],
      location: map['location']
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'titleTxt': titleTxt,
      'subTxt': subTxt,
      'desc1': desc1,
      'desc2': desc2,
      'perDay': perDay,
      'location': location
    };
  }
}
