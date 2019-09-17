import 'package:bizynest/pages/home.dart';
import 'package:bizynest/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:bizynest/pages/login_page.dart';
import 'package:bizynest/models/enums.dart';
import 'package:flutter/rendering.dart';
import 'services/UserService.dart';

// One simple action: Increment
//enum Actions { Increment }

// The reducer, which takes the previous count and increments it in response
// to an Increment action.
// int counterReducer(int state, dynamic action) {
//   if (action == Actions.Increment) {
//     return state + 1;
//   }

//   print(state);

//   return state;
// }

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
  // This widget is the root of your application.

  //final store = new Store<int>(counterReducer, initialState: 0);

  // final store = new Store<AppState>(
  //   appReducer,
  //   initialState: new AppState(),
  //   middleware: []
  //     ..addAll(createAuthMiddleware())
  //     ..add(new LoggingMiddleware.printer()),
  // );

}

class _MyAppState extends State<MyApp> {
  bool _validUser = false;
  bool _processing = true;

  @override
  void initState() {
    super.initState();
    _checkValidUser().then((valid) {
      setState(() {
        _validUser = valid;
        _processing = false;
      });
    }).catchError((e) => print(e));
  }

  Future<bool> _checkValidUser() async {
    try {
      var token = await MySharedPreferences.getUser();
      if (token == null) return false;
      Map x = await UserService.loginUser(token['username'], token['password']);
      if (x == null) return false;
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // return new StoreProvider(
    // Pass the store to the StoreProvider. Any ancestor `StoreConnector`
    // Widgets will find and use this value as the `Store`.
    // store: store,
    return MaterialApp(
      title: 'Bizynest',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          primaryColor: new Color(0xff601183)),
      home: !_processing && _validUser
          ? HomePage()
          : LoginPage(
              title: 'Flutter Demo Home Page',
            ),
    );
  }
}
