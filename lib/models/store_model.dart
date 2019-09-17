class Store {
  String store_id;
  String store_uid;
  String sname;
  final String saddress;
  final String sdate;
  final String slogo;
  final String expires;

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

  Store({
    this.store_id,
    this.store_uid,
    this.sname,
    this.saddress,
    this.sdate,
    this.slogo,
    this.expires,
  });

  /*
  Map<String, dynamic> mapJson = document.data;
new MyObject.fromJson(json.decode(json.encode(mapJson))));
   */

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      //id: json['data'][0]['id'] as String,
      //name: json['data'][0]['name'] as String,
      store_id: json['store_id'] as String,
      store_uid: json['store_uid'] as String,
      sname: json['sname'] as String,
      saddress: json['saddress'] as String,
      sdate: json['sdate'] as String,
      slogo: json['slogo'] as String,
      expires: json['expires'] as String,
    );
  }
}
