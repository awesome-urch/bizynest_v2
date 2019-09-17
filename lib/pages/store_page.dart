import 'dart:convert';

import 'package:bizynest/constants.dart';
import 'package:bizynest/services/rest_api.dart';
import 'package:bizynest/models/store_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class StorePage extends StatefulWidget {
  final Store store;

  StorePage({Key key, @required this.store}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Store'),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: ListView(
            padding: EdgeInsets.fromLTRB(12, 12, 12, 24.0),

          ),
        )
    );
  }

}