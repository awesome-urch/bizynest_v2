class Product {
  final String pname;
  final String pphoto;
  final String pprice;
  final String store_uid;
  final String views;
  final String featured;
  final String likes;
  final String store_id;
  final String product_id;
  final String sowner;
  final String like_users;
  String pdesc;
  final String pcategory;
  final String pstore_id;
  final String in_stock;
  bool liked;

  Product({
    this.pname,
    this.pphoto,
    this.pprice,
    this.store_uid,
    this.views,
    this.featured,
    this.likes,
    this.store_id,
    this.product_id,
    this.sowner,
    this.like_users,
    this.pdesc,
    this.pcategory,
    this.pstore_id,
    this.in_stock,
    this.liked,
  });

  /*
  Map<String, dynamic> mapJson = document.data;
new MyObject.fromJson(json.decode(json.encode(mapJson))));
   */

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      //id: json['data'][0]['id'] as String,
      //name: json['data'][0]['name'] as String,
      pname: json['pname'] as String,
      pphoto: json['pphoto'] as String,
      pprice: json['pprice'] as String,
      store_uid: json['store_uid'] as String,
      views: json['views'] as String,
      featured: json['featured'] as String,
      likes: json['likes'] as String,
      store_id: json['store_id'] as String,
      product_id: json['product_id'] as String,
      sowner: json['sowner'] as String,
      like_users: json['like_users'] as String,
      pdesc: json['pdesc'] as String,
      pcategory: json['pcategory'] as String,
      pstore_id: json['pstore_id'] as String,
      in_stock: json['in_stock'] as String,
      liked: (json['liked'] == 1),
    );
  }
}
