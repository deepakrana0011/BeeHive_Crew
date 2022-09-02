class SetProjectRateCrew {
  String? crewId;
  String? price;

  SetProjectRateCrew({this.crewId, this.price});

  SetProjectRateCrew.fromJson(Map<String, dynamic> json) {
    crewId = json['crewId'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crewId'] = this.crewId;
    data['price'] = this.price;
    return data;
  }
}