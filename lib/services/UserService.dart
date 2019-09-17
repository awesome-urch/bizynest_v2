import 'dart:convert';
import 'dart:io';
import 'package:bizynest/models/category_model.dart';
import 'package:bizynest/services/rest_api.dart';
import 'package:bizynest/tryit/form.dart';
import 'package:bizynest/utils/prefs.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<Map> createUser(User user) async {
    Map<String, String> map = _toMap(user);
    map.addAll({'request': 'create_account'});
    final response = await http.post(
      RestApi.REST_URL_POST,
      // headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: map,
    );

    // final response = await http.post(RestApi.REST_URL_POST, body: jsonString);
    Map responseBody;
    try {
      responseBody = json.decode(response.body);
    } catch (e) {
      print(e);
      // return null;
    }

    if (responseBody == null ||
        responseBody['error'] != 0 ||
        responseBody['data'] == null) {
      throw 'Please check your form details';
    }

    return responseBody['data'];
  }

  static Map<String, String> _toMap(User user) {
    Map<String, String> mapData = new Map();
    // mapData['request'] = 'create_account';
    mapData['firstname'] = user.firstname;
    mapData['surname'] = user.surname;
    mapData['username'] = user.username;
    mapData['email'] = user.email;
    mapData['password'] = user.password;
    mapData['location'] = user.location;
    mapData['interest'] = _interestsToString(user.interests);

    // return json.encode(mapData);
    return mapData;
  }

  static String _interestsToString(final List<MyCategory> interests) {
    String string = interests[0].id;
    interests.skip(1).forEach((value) => string = '$string,${value.id}');
    return string;
  }

  static Future<Map> loginUser(String username, String password) async {
    final response = await http.get(
      RestApi.REST_URL_GET +
          "?request=login&username=" +
          username +
          "&password=" +
          password,
    );

    Map map = json.decode(response.body);
    if (map['error'] != 0) {
      throw 'Invalid username or password';
    }

    var data = map['data'];
    print('surname: ' + data['surname'] + ' firstname: ' + data['firstname']);
    MySharedPreferences.setUser(username, password, data['merchant_id']);

    return map['data'];
  }
}
