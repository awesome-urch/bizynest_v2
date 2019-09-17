import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static Future<Map<String, String>> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> user = prefs.getStringList('user');
    if (user == null) return null;
    return {
      'username': user[0],
      'password': user[1],
      'id': user[2],
    };
  }

  // static Future<String> getUserId() async {
  //   var user = await getUser();
  //   return user['id'];
  // }

  static setUser(String username, String password, id) async {
    List<String> user = [username, password, id];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList('user', user);
  }

  static removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('user');
  }
}
