import 'package:bizynest/helpers/validator_methods.dart';
import 'package:bizynest/models/category_model.dart';
import 'package:bizynest/pages/home.dart';
import 'package:bizynest/services/UserService.dart';
import 'package:bizynest/services/rest_api.dart';
import 'package:bizynest/utils/prefs.dart';
import 'package:bizynest/widgets/common_widgtes.dart';
import 'package:bizynest/widgets/list_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bizynest/constants.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  Future<List<MyCategory>> _interests;
  bool obsurePassword = true;
  String _password;
  bool _autovalidate = false;
  final User _user = new User();
  final List<String> _locations = AppConstants.NIG_STATES;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _spacer = Container(padding: const EdgeInsets.fromLTRB(0, 10, 0, 10));

  @override
  void initState() {
    super.initState();
    _interests = RestApi.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    CommonWidgets commonWidgets = CommonWidgets(context: context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _formKey,
          autovalidate: _autovalidate,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.1, 0.7],
                colors: [
                  Color(0xFF601183),
                  Color(0x88601183),
                ],
              ),
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(32.0, 48.0, 32.0, 24.0),
                  child: Image.asset(
                    "assets/logo_extended.png",
                    fit: BoxFit.contain,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Firstname',
                    hintText: 'Enter your firstname',
                    prefixIcon: const Icon(Icons.person),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  validator: (val) =>
                      val.isEmpty ? 'Firstname is required' : null,
                  onSaved: (val) => _user.firstname = val,
                ),
                _spacer,
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Surname',
                    hintText: 'Enter your surname',
                    prefixIcon: const Icon(Icons.person),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  validator: (val) =>
                      val.isEmpty ? 'Surname is required' : null,
                  onSaved: (val) => _user.surname = val,
                ),
                _spacer,
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your username',
                    prefixIcon: const Icon(Icons.person),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  validator: (val) =>
                      val.isEmpty ? 'Username is required' : null,
                  onSaved: (val) => _user.username = val,
                ),
                _spacer,
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: const Icon(Icons.email),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  validator: (val) => isValidEmail(val)
                      ? null
                      : 'Please enter a valid email address',
                  onSaved: (val) => _user.email = val,
                  keyboardType: TextInputType.emailAddress,
                ),
                _spacer,
                TextFormField(
                  obscureText: obsurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(obsurePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          obsurePassword = !obsurePassword;
                        });
                      },
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  validator: (val) {
                    _password = val;
                    if (val.isEmpty) return 'Please enter a password';
                    if (val.length < 6) return 'Password is too short';
                    return null;
                  },
                  onSaved: (val) => _user.password = val,
                  keyboardType: TextInputType.emailAddress,
                ),
                _spacer,
                TextFormField(
                  obscureText: obsurePassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Confirm your password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(obsurePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          obsurePassword = !obsurePassword;
                        });
                      },
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  validator: (val) {
                    if (val != _password) return 'Password does not match';
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                _spacer,
                FormField(
                  builder: (FormFieldState state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.place),
                        labelText: 'Location',
                        hintText: 'Select state',
                        errorText: state.hasError ? state.errorText : null,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      isEmpty: _user.location == null,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          // hint: Text('Select state'),
                          value: _user.location,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _user.location = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: _locations.map(
                            (String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(growable: false),
                        ),
                      ),
                    );
                  },
                  validator: (value) {
                    if (_user.location == null) {
                      return 'Please select a location';
                    }
                    return null;
                  },
                ),
                _spacer,
                Text(
                  "Select Interest",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16.0,
                  ),
                ),
                FormField(
                  builder: (FormFieldState state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        errorText: state.hasError ? state.errorText : null,
                      ),
                      isEmpty: _user.interests.isEmpty,
                      child: FutureBuilder(
                        future: _interests,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.active:
                            case ConnectionState.waiting:
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            case ConnectionState.done:
                              if (snapshot.hasError) {
                                return Center(
                                  child: Column(
                                    children: <Widget>[
                                      Text('An error occurred'),
                                      commonWidgets.buildButtonMaterial(
                                        label: 'Reload',
                                        color: AppConstants.appPurple,
                                        callback: () {
                                          setState(() {
                                            _interests =
                                                RestApi.fetchCategories();
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                );
                              }
                              return Container(
                                // margin: edgeInsets,
                                height: 200,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Expanded(
                                      child: ListViewCategories(
                                        selectedInterests: _user.interests,
                                        interests: snapshot.data,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _user.interests = newValue;
                                            state.didChange(newValue);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                          }
                        },
                      ),
                    );
                  },
                  validator: (value) {
                    if (_user.interests.isEmpty) {
                      return 'Please select at least an interest';
                    }
                    return null;
                  },
                ),
                _spacer,
                commonWidgets.buildButtonMaterial(
                  label: 'Complete Registration',
                  color: AppConstants.appBlue,
                  callback: _handleRegister,
                ),
                _spacer,
              ],
            ),
          ),
        ),
      ),
    );
  }

  _handleRegister() {
    setState(() {
      // _autovalidate = true;
    });
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      print('nah');
      return;
    }

    form.save();

    MySharedPreferences.getUser();

    UserService.createUser(_user).then((data) {
      String d = data['surname'];
      print(d);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ),
      );
    }).catchError((e) {
      var commonWidgets = CommonWidgets(context: context);
      final snk = commonWidgets.buildSnackBar(action: false, text: '$e');
      _scaffoldKey.currentState.showSnackBar(snk);

      // Scaffold.of(ctx).showSnackBar(snk);
    });
  }
}

class User {
  String firstname;
  String surname;
  String username;
  String email;
  String password;
  String confirmPassword;
  String location;
  List<MyCategory> interests = [];
  // String
}
