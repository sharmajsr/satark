class Address {
  final String placeId;
  final String name;
  final String state;
  final String city;
  final String postcode;

  Address({this.placeId, this.name, this.state,this.city,this.postcode});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      placeId: json['place_id'],
      name: json['name'],
      city: json['city'],
      state: json['state'],
      postcode: json['postcode'],
    );
  }
}