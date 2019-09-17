class TopStore {
  final String store_id;
  final String sname;
  final String saddress;
  final String store_uid;
  final String sphone;
  final String semail;
  final String store_cover;
  final String slogo;
  final String views;
  final String sinfo;
  final String merchant_id;
  final String firstname;
  final String surname;
  final String stars;
  final String followers;
  final String picture;

  /*private String store_id;
  private String sname;
  private String saddress;
  private String store_uid;
  private String sphone;
  private String semail;
  private String store_cover;
  private String slogo;
  private String views;
  private String sinfo;
  private String merchant_id;
  private String firstname;
  private String surname;
  private String stars;
  private String followers;
  private String picture;*/

  TopStore({
    this.store_id,
    this.store_uid,
    this.sname,
    this.saddress,
    this.sphone,
    this.semail,
    this.store_cover,
    this.views,
    this.sinfo,
    this.merchant_id,
    this.firstname,
    this.surname,
    this.stars,
    this.followers,
    this.picture,
    this.slogo,
  });

  factory TopStore.fromJson(Map<String, dynamic> json) {
    return TopStore(
      //id: json['data'][0]['id'] as String,
      //name: json['data'][0]['name'] as String,
      store_id: json['store_id'] as String,
      store_uid: json['store_uid'] as String,
      sname: json['sname'] as String,
      saddress: json['saddress'] as String,
      slogo: json['slogo'] as String,
      sphone: json['sphone'] as String,
      semail: json['semail'] as String,
      store_cover: json['store_cover'] as String,
      views: json['views'] as String,
      sinfo: json['sinfo'] as String,
      merchant_id: json['merchant_id'] as String,
      firstname: json['firstname'] as String,
      surname: json['surname'] as String,
      stars: json['stars'] as String,
      followers: json['followers'] as String,
      picture: json['picture'] as String,

    );
  }
}
