import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:bizynest/models/category_model.dart';

enum FriendAction {
  ADD_TO_CONTACT,
  ACCEPT_REQUEST,
  CANCEL_REQUEST,
}

class RestApi {
  static const String WEB_URL = "https://bizynest.com/";
  static const String BASE_URL =
      "https://bizynest.com/api/src/routes/"; //http://192.168.0.100/pagesn/  //https://bizynest.com/api/src/routes/
  static const String REST_URL_GET = BASE_URL + "process_one.php";
  static const String REST_URL_POST = BASE_URL + "process_post.php";
  static const String REST_URL_TEST = BASE_URL + "test.php";
  static const String UPLOAD_PAT = "api/src/routes/";

  static Future<List<MyCategory>> fetchCategories() async {
    //https://jsonplaceholder.typicode.com/photos
    //https://bizynest.com/api/src/routes/process_one.php?request=categories
    //http://192.168.0.100/pagesn/process_one.php?request=categories2
    final response = await http.get(REST_URL_GET + '?request=categories');
    final body = json.decode(response.body);
    return compute(parsePosts, jsonEncode(body['data']));
  }

  static List<MyCategory> parsePosts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<MyCategory>((json) => MyCategory.fromJson(json)).toList();
  }

  static Future<String> createAccount(Map<String, String> body) async {
    const URL = RestApi.REST_URL_POST + '?request=create_account';
    final response = await http.post(
      URL,
      body: body,
    );

    return response.body;
  }

  static Future likeProduct({user_id, product_id, store_id}) async {
    var url = RestApi.REST_URL_GET +
        '?request=like_product&pid=$product_id&uid=$user_id&sid=$store_id';

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to like or unlike product');
    }

    print(url);
    var body = json.decode(response.body);

    return body['data'];
  }

  static Future fetchProducts() async {
    final response = await http.get(RestApi.REST_URL_GET + '?request=products');

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch products');
    }

    //print(response.body);
    final body = json.decode(response.body);
    return body['data'];
  }

  static Future fetchUserProducts(userId) async {
    final response = await http
        .get(RestApi.REST_URL_GET + '?request=products&uid=$userId&limit=40');

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch user products');
    }

    final body = json.decode(response.body);
    return body['data'];
  }

  static Future fetchOwner(profileId, {userId}) async {
    final url = RestApi.REST_URL_GET + "?request=info&id=$profileId&user=$userId";
    return getRequest(url);
  }

  static Future postFriendAction(userId, profileId,
      {@required FriendAction friendAction}) async {
    var action;
    switch (friendAction) {
      case FriendAction.ADD_TO_CONTACT:
        action = 'send';
        break;
      case FriendAction.ACCEPT_REQUEST:
        action = 'accept';
        break;
      case FriendAction.CANCEL_REQUEST:
        action = 'reject';
        break;
    }

    final url = RestApi.REST_URL_GET +
        '?request=add_friend&sender=$userId&receiver=$profileId&action=$action';
    return getRequest(url);
  }

  static Future updateStatus(profileId, String status) async {
    final url = RestApi.REST_URL_GET +
        "?request=update_anywhere&table=merchants&col=vstatus&id_col=merchant_id&id=$profileId&val=$status";
    return getRequest(url);
  }

  static Future follow(userId, profileId) async {
    const type = '0';
    final url = RestApi.REST_URL_GET +
        "?request=follow&type=$type&uid=$userId&did=$profileId";
    return getRequest(url);
  }

  static Future getRequest(String url) async {
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw Exception('Request failed.');
      }

      final body = json.decode(response.body);
      final data = body['data'];
      if (data == null) {
        throw Exception('Error in request');
      }

      return data;
    } catch (e) {
      throw e;
    }
  }
}
