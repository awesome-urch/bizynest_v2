class Owner {
  final String sowner;
  final String merchant_id;
  final String surname;
  final String location;
  final String picture;
  final String firstname;
  final String stars;

  Owner({
    this.sowner,
    this.merchant_id,
    this.surname,
    this.location,
    this.picture,
    this.firstname,
    this.stars,
  });

  /*
  Map<String, dynamic> mapJson = document.data;
new MyObject.fromJson(json.decode(json.encode(mapJson))));
   */

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      //id: json['data'][0]['id'] as String,
      //name: json['data'][0]['name'] as String,
      merchant_id: json['merchant_id'] as String,
      surname: json['surname'] as String,
      location: json['location'] as String,
      picture: json['picture'] as String,
      firstname: json['firstname'] as String,
      stars: json['stars'] as String,
      sowner: json['sowner'] as String,
    );
  }
}
