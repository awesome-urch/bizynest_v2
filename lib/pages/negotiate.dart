import 'dart:convert';

import 'package:bizynest/constants.dart';
import 'package:bizynest/models/owner.dart';
import 'package:bizynest/models/product_model.dart';
import 'package:bizynest/pages/view_profile.dart';
import 'package:bizynest/services/rest_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Negotiate extends StatefulWidget {
  final Product post;

  Negotiate({Key key, @required this.post}) : super(key: key);

  @override
  _NegotiateState createState() => _NegotiateState();
}

class _NegotiateState extends State<Negotiate> {
  Product post;
  Owner owner;

  Future fetchPosts(product_id, store_id) async {
    try {
      final response = await http.get(RestApi.REST_URL_GET +
          '?request=view_product&pid=$product_id&uid=${172}&sid=$store_id');
      final body = json.decode(response.body);
      final data = body['data'];
      final aPost = Product.fromJson(data);
      final o = data['owner'];

      setState(() {
        post.pdesc = aPost.pdesc;
        post.liked = aPost.liked;
        owner = Owner.fromJson(o);
      });
    } catch (e) {
      print('$e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    post = widget.post;

    // fetch API
    fetchPosts(post.product_id, post.store_id);
  }

  final _spacer = Container(
    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
  );

  final _spacerSmall = Container(
    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
  );

  final _spacerVertical = Container(
    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
  );

  final _spacerVerticalSmall = Container(
    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
  );

  @override
  Widget build(BuildContext context) {
    // Product post = widget.post;

    Widget nameSection = Center(
      child: Text(
        post.pname,
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );
    Widget descriptionSection = Center(
      child: Text(
        post.pdesc == null ? '' : post.pdesc,
        style: TextStyle(
          fontSize: 16,
          height: 1.25,
        ),
        softWrap: true,
      ),
    );

    Widget rowIcon({IconData icon, String text}) => Row(
          children: <Widget>[
            Icon(icon),
            Text(text),
          ],
        );

    Widget likesViewsSection = Row(
      children: <Widget>[
        rowIcon(icon: Icons.thumb_up, text: post.likes),
        _spacerVerticalSmall,
        rowIcon(icon: Icons.remove_red_eye, text: post.views),
      ],
    );

    Form negotiateForm = Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        // mainAxisAlignment: MainAxisAlignment.,
        children: <Widget>[
          Container(
            width: 200,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Negotiate',
                hintText: 'Enter your bid price',
                // contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ),
          _spacerSmall,
          Container(
            height: 20,
            child: Material(
              color: AppConstants.appPurple,
              child: MaterialButton(
                child: Text(
                  'SEND',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );

    Widget btn(
        {Color color,
        onPressed,
        String text: '',
        double minWidth,
        double width,
        double height}) {
      return Container(
        width: width,
        height: height,
        child: Material(
          color: color,
          child: MaterialButton(
            minWidth: minWidth,
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: onPressed,
          ),
        ),
      );
    }

    Widget stockSection = Row(
      children: <Widget>[
        Expanded(
          child: btn(text: 'In Stock', color: Colors.green),
        ),
        Expanded(
          child: btn(text: '₦ ${post.pprice}', color: AppConstants.appPurple),
        ),
      ],
    );

    Widget likeVisitStoreRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.blue,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Icon(
                    post.liked ? Icons.thumb_down : Icons.thumb_up,
                    color: Colors.white,
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: btn(
                      color: Colors.blue,
                      text: post.liked ? 'Unlike' : 'Like',
                      onPressed: () {
                        RestApi.likeProduct(
                          product_id: post.product_id,
                          store_id: post.store_id,
                          user_id: 172,
                        ).then((data) {
                          setState(() {
                            data['action'] == 'liked'
                                ? post.liked = true
                                : post.liked = false;
                          });
                        }).catchError((e) {
                          // error
                        });
                      }),
                  flex: 3,
                ),
              ],
            ),
          ),
          flex: 5,
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Expanded(
          child: btn(color: Colors.blue, text: 'Visit Store'),
          flex: 5,
        ),
      ],
    );

    Widget imageSection = Image.network(
      AppConstants.BASE_WEBSITE + post.pphoto,
      width: 600,
      height: 240,
      fit: BoxFit.cover,
    );

    Widget reportShareRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          child: btn(color: Colors.red, text: 'Report'),
          flex: 5,
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Expanded(
          child: btn(color: Colors.blue, text: 'Share'),
          flex: 5,
        ),
      ],
    );

    Widget ownerCard() {
      return Card(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  owner.picture == null
                      ? Image.asset(
                          'images/icon.png',
                          width: 75,
                          height: 75,
                          fit: BoxFit.cover,
                        )
                      : FadeInImage.assetNetwork(
                          placeholder: 'images/icon.png',
                          width: 75,
                          height: 75,
                          fit: BoxFit.cover,
                          image: AppConstants.BASE_WEBSITE + owner.picture,
                        ),
                  _spacerVertical,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${owner.firstname} ${owner.surname}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      _spacer,
                      Text(owner.location),
                    ],
                  ),
                ],
              ),
              _spacer,
              btn(
                  text: 'View Profile',
                  color: AppConstants.appPurple,
                  height: 25,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        // builder methods always take context!
                        builder: (context) {
                          return ViewProfile(
                            ownerId: owner.merchant_id,
                          );
                        },
                      ),
                    );
                  }),
            ],
          ),
        ),
      );
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Negotiate'),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: ListView(
          padding: EdgeInsets.fromLTRB(12, 12, 12, 24.0),
          children: <Widget>[
            imageSection,
            _spacer,
            nameSection,
            Divider(),
            descriptionSection,
            Divider(),
            // _spacer,
            // more photos
            likesViewsSection,
            Divider(),
            // _spacer,
            // negotiate form
            Center(
              child: Text(
                'Negotiate',
                style: TextStyle(fontSize: 24),
              ),
            ),
            _spacer,
            negotiateForm,
            _spacer,
            // in stock row
            stockSection,
            _spacer,
            // like and visit store row
            likeVisitStoreRow,
            _spacer,
            // report and share row
            reportShareRow,
            _spacer,
            // owner section
            Divider(),
            _spacerSmall,
            owner == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ownerCard(),
          ],
        ),
      ),
    );
  }
}
