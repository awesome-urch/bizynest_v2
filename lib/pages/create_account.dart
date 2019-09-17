import 'package:flutter/material.dart';
import 'package:bizynest/widgets/common_widgtes.dart';
import 'package:bizynest/constants.dart';
import 'package:bizynest/pages/login_page.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:bizynest/models/category_model.dart';
import 'package:bizynest/widgets/list_category.dart';
import 'package:bizynest/services/rest_api.dart';

const EdgeInsets edgeInsets = EdgeInsets.fromLTRB(28.0, 20.0, 28.0, 20.0);

class CreateAccountPage extends StatefulWidget {
  final String title;
  //final Store<int> store;

  CreateAccountPage({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  bool _isProcessing = false;
  String error;
  List<String> stateList = AppConstants.NIG_STATES;
  String selectedState = null;
  List<MyCategory> selectedInterests = [];
  Future<List<MyCategory>> interests;
  final _formKey = GlobalKey<FormState>();

// Text field controllers
  final firstnameController = TextEditingController();
  final surnameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    interests = RestApi.fetchCategories();
  }

  @override
  void dispose() {
    firstnameController.dispose();
    surnameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool _isEmpty(String string) => [null, ''].contains(string);

  _handleSelectInterest(MyCategory interest) {
    if (interest.checked)
      selectedInterests.add(interest);
    else
      selectedInterests.remove(interest);
  }

  _handleReloadInterests() {
    setState(() {
      interests = RestApi.fetchCategories();
    });
  }

  Future<String> createPost() async {
    setState(() {
      _isProcessing = true;
    });
  }

  _process() async {
    String msg;

    if (_formKey.currentState.validate()) {
      print('validated');
    } else {
      print('nah');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget firstNameInputField = _InputTextWidget(
      autofocus: true,
      hint: 'Firstname',
      controller: firstnameController,
    );
    Widget surnameInputField = _InputTextWidget(
      hint: 'Surname',
      controller: surnameController,
    );
    Widget usernameInputField = _InputTextWidget(
      hint: 'Username',
      controller: usernameController,
    );
    Widget emailInputField = _InputTextWidget(
      hint: 'Email',
      controller: emailController,
    );
    Widget pwdInputField = _InputTextWidget(
      hint: 'Password',
      obscure: true,
      controller: passwordController,
    );
    Widget cpwdInputField = _InputTextWidget(
      hint: 'Confirm Password',
      obscure: true,
      controller: confirmPasswordController,
    );

    Widget interestBuilder() {
      return FutureBuilder<List<MyCategory>>(
        future: interests,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    children: <Widget>[
                      Text('An error occurred'),
                      _ReloadInterestBtn(
                        onPressed: _handleReloadInterests,
                      ),
                    ],
                  ),
                );
              }
              return ListViewCategories(
                selectedInterests: selectedInterests,
                interests: snapshot.data,
                onChanged: (interests) {
                  setState(() {
                    selectedInterests = interests;
                  });
                },
              );
          }
        },
      );
    }

    CommonWidgets commonWidgets = CommonWidgets(context: context);
    Widget footSection = Container(
        margin: edgeInsets,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              /*margin: EdgeInsets.all(10.0),*/
              child: Text(
                'Already have an account?',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Expanded(
              //margin: EdgeInsets.all(10.0),
              child: commonWidgets.buildButtonMaterial(
                  label: 'Sign in',
                  color: Colors.white,
                  textColor: AppConstants.appPurple,
                  minWidth: 50.0,
                  callback: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        // builder methods always take context!
                        builder: (context) {
                          return LoginPage();
                        },
                      ),
                    );
                  }),
            )
            /*Container(
            child: commonWidgets.buildButtonMaterial(label: 'Sign in',color: Colors.white, textColor: AppConstants.appPurple),
          ),*/
          ],
        ));

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the LoginPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Create Account'),
      ),
      body: Form(
        key: _formKey,
        autovalidate: true,
        child: Container(
          decoration: BoxDecoration(
            // Box decoration takes a gradient
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              // Add one stop for each color. Stops should increase from 0 to 1
              stops: [0.1, 0.7],
              colors: [
                // Colors are easy thanks to Flutter's Colors class.

                Color(0xFF601183),
                Color(0x88601183),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(32.0, 48.0, 32.0, 24.0),
                      child: Image.asset(
                        "assets/logo_extended.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Center(
                      child: Text(_isEmpty(error) ? '' : error),
                    ),
                    firstNameInputField,
                    surnameInputField,
                    // surnameInputField,
                    usernameInputField,
                    emailInputField,
                    pwdInputField,
                    cpwdInputField,
                    Container(
                      margin: EdgeInsets.fromLTRB(28.0, 20.0, 28.0, 0.0),
                      child: Text(
                        "Select Location",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: edgeInsets,
                      child: DropdownButton<String>(
                        hint: Text('Select State'),
                        value: selectedState,
                        items: stateList
                            .map<DropdownMenuItem<String>>(
                                (state) => DropdownMenuItem<String>(
                                      child: Text(state),
                                      value: state,
                                    ))
                            .toList(growable: false),
                        onChanged: (value) {
                          debugPrint('state: $value');
                          print(value);
                          setState(() {
                            selectedState = value;
                          });
                        },
                        isExpanded: true,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(28.0, 20.0, 28.0, 0.0),
                      child: Text(
                        "Select Interest",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: edgeInsets,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: interestBuilder(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: edgeInsets,
                      child: commonWidgets.buildButtonMaterial(
                        label: 'Complete Registration',
                        color: AppConstants.appBlue,
                        callback: () => _process(),
                      ),
                    ),
                    footSection,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputTextWidget extends StatelessWidget {
  _InputTextWidget({
    @required this.hint,
    this.obscure: false,
    this.controller,
    this.validator,
    this.autofocus: false,
  });
  final String hint;
  final bool obscure;
  final TextEditingController controller;
  final validator;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: edgeInsets,
      child: TextFormField(
        // autovalidate: true,
        autofocus: autofocus,
        style: TextStyle(color: Colors.white),
        obscureText: obscure,
        controller: controller,
        validator: [null].contains(validator)
            ? (value) {
                if (value.isEmpty) return 'Fill this field';
                return null;
              }
            : validator,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: hint,
          // hintStyle: TextStyle(color: Colors.grey[500]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }
}

class _ReloadInterestBtn extends StatelessWidget {
  _ReloadInterestBtn({this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Builder(
      // Create an inner BuildContext so that the onPressed methods
      // can refer to the Scaffold with Scaffold.of().
      builder: (BuildContext context) {
        return Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(0.0),
          color: AppConstants.appPurple,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: onPressed,
            child: Text(
              'Reload',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
        );
      },
    );
  }
}

typedef onTextChangedCallback = Function(String text);
