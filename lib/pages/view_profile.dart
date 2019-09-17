import 'dart:convert';

import 'package:bizynest/constants.dart';
import 'package:bizynest/models/product_model.dart';
import 'package:bizynest/services/rest_api.dart';
import 'package:bizynest/utils/prefs.dart';
import 'package:bizynest/utils/spacer.dart';
import 'package:bizynest/widgets/list_product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewProfile extends StatefulWidget {
  final ownerId;

  ViewProfile({Key key, this.ownerId}) : super(key: key);

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  bool downloaded = false;
  bool isMe = false;
  var userId;
  var profile;
  var profileId;
  TextEditingController statusController = TextEditingController();

  static Future<List<Product>> fetchUserProducts(userId) async {
    final data = await RestApi.fetchUserProducts(userId);
    return compute(parsePosts, jsonEncode(data));
  }

  static List<Product> parsePosts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
    initializeState();
  }

  void initializeState() async {
    final user = await MySharedPreferences.getUser();
    userId = user['id'];
    profile = await RestApi.fetchOwner(widget.ownerId, userId: userId);

    downloaded = true;
    profileId = profile['merchant_id'];
    isMe = userId == profileId;

    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    statusController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: downloaded
          ? buildStack()
          // ? _homeContainer()
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget buildStack() {
    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                color: Colors.grey[350],
              ),
            ),
            Image.asset(
              'images/store_cover_default.jpg',
              height: 200,
              fit: BoxFit.cover,
            ),
            Container(
              // margin: EdgeInsets.fromLTRB(20, 100, 20, 20),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 100, 20, 0),
                    child: buildProfileContainer(),
                  ),
                  MySpacer(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: buildDetailsContainer(),
                  ),
                  MySpacer(),
                  buildProductGrid(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildProductGrid() {
    return FutureBuilder<List<Product>>(
      future: fetchUserProducts(profile['merchant_id']),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? ListViewProducts(posts: snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Container buildProfileContainer() {
    bool isRship = profile['relationship'] == 'yes';
    bool weAreNotFriendsYet = '${profile['friend_status']}' == '0';
    bool requestIsFromMe = profile['request_from'] == userId;

    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          MySpacer(
            size: MySpacer.SMALL,
          ),
          _circleAvatar(),
          MySpacer(),
          Text(
            '${profile['firstname']} ${profile['surname']}',
            style: TextStyle(
              color: AppConstants.appPurple,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          MySpacer(),
          Text(
            profile['location'],
            style: TextStyle(color: Colors.grey),
          ),
          MySpacer(),
          if (isMe)
            _buildRaisedButton(
              text: 'EDIT PROFILE',
              onPressed: _onEditProfile,
            ),
          if (!isMe && !isRship)
            _buildRaisedButton(
              text: 'ADD TO CONTACTS',
              onPressed: _onAddToContacts,
            ),
          if (isRship && weAreNotFriendsYet && requestIsFromMe)
            _buildRaisedButton(
              text: 'CANCEL REQUEST',
              onPressed: _onCancelRequest,
            ),
          if (isRship && weAreNotFriendsYet && !requestIsFromMe)
            _buildRaisedButton(
              text: 'ACCEPT REQUEST',
              onPressed: _onAcceptRequest,
            ),
          if (isRship && weAreNotFriendsYet && !requestIsFromMe)
            _buildRaisedButton(
              text: 'DECLINE REQUEST',
              onPressed: _onCancelRequest,
            ),
          if (isRship && !weAreNotFriendsYet)
            _buildRaisedButton(
              text: 'UNFRIEND',
              onPressed: _onCancelRequest,
            ),
          if (!isMe)
            _buildRaisedButton(
              text: '${profile['is_following']}' == '1' ? 'UNFOLLOW' : 'FOLLOW',
              onPressed: _onFollow,
            ),
          if (!isMe)
            _buildRaisedButton(
              text: 'SEND A PRIVATE MESSAGE',
              onPressed: _onMessage,
            ),
          MySpacer(size: MySpacer.SMALL),
        ],
      ),
    );
  }

  Container buildDetailsContainer() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          MySpacer(
            size: MySpacer.SMALL,
          ),
          buildRow(
              icon: Icons.calendar_today,
              text: 'Member Since',
              value: "Sun, Mar 17, '19"),
          Divider(),
          buildRow(
            icon: Icons.remove_red_eye,
            text: 'Views',
            value: "${profile['views']}",
          ),
          Divider(),
          buildRow(
            icon: Icons.people,
            text: 'Followers',
            value: "${profile['followers']}",
          ),
          Divider(),
          buildRow(
            icon: Icons.people_outline,
            text: 'Following',
            value: "${profile['following']}",
          ),
          Divider(),
          buildRow(
            icon: Icons.contacts,
            text: 'Contacts',
            value: "${profile['contacts']}",
          ),
          Divider(),
          buildRow(
            icon: Icons.collections_bookmark,
            text: 'Topics',
            value: "${profile['topics']}",
          ),
          Divider(),
          buildRow(
            icon: Icons.email,
            text: 'Email',
            value: "${profile['email']}",
          ),
          Divider(),
          buildRow(
            icon: Icons.message,
            text: 'Status',
            isStatus: true,
            value: "${profile['vstatus']}",
          ),
          MySpacer(
            size: MySpacer.SMALL,
          ),
        ],
      ),
    );
  }

  Widget buildRow(
      {IconData icon, String text, String value, bool isStatus: false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
          Icon(icon),
          MySpacer(
            isVertical: true,
            size: MySpacer.SMALL,
          ),
          Expanded(
            flex: 4,
            child: Text(text),
          ),
          MySpacer(
            isVertical: true,
            size: MySpacer.SMALL,
          ),
          if (!isStatus)
            Expanded(
              flex: 6,
              child: Text(
                value,
                textAlign: TextAlign.right,
              ),
            )
          else
            _buildStatus(value: value)
        ],
      ),
    );
  }

  Widget _buildStatus({value}) {
    statusController.text = value;
    return Expanded(
      flex: 10,
      child: Column(
        children: <Widget>[
          TextField(
            textAlign: TextAlign.justify,
            enabled: isMe,
            controller: statusController,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.done,
            textCapitalization: TextCapitalization.sentences,
            maxLength: 120,
            maxLines: null,
            decoration: InputDecoration(
              enabled: isMe,
              labelText: '',
              hintText: 'Enter your status',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
          if (isMe)
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 90,
                height: 25,
                child: _buildRaisedButton(
                  text: 'UPDATE',
                  onPressed: _onUpdateStatus,
                ),
              ),
            )
        ],
      ),
    );
  }

  RaisedButton _buildRaisedButton({@required String text, onPressed}) {
    return RaisedButton(
      color: Colors.blue,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: onPressed,
    );
  }

  Widget _circleAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: FadeInImage.assetNetwork(
        placeholder: 'images/icon.png',
        width: 200,
        height: 200,
        fit: BoxFit.cover,
        image: AppConstants.BASE_WEBSITE + profile['picture'],
      ),
    );
  }

  _setProfile() async {
    profile = await RestApi.fetchOwner(widget.ownerId, userId: userId);
  }

  _onAddToContacts() async {
    downloaded = false;
    setState(() {});
    try {
      await RestApi.postFriendAction(userId, profileId,
          friendAction: FriendAction.ADD_TO_CONTACT);
      await _setProfile();
    } catch (e) {
      print(e);
    } finally {
      downloaded = true;
      if (mounted) setState(() {});
    }
  }

  _onAcceptRequest() async {
    downloaded = false;
    setState(() {});
    try {
      await RestApi.postFriendAction(userId, profileId,
          friendAction: FriendAction.ACCEPT_REQUEST);
      await _setProfile();
    } finally {
      downloaded = true;
      if (mounted) setState(() {});
    }
  }

  _onCancelRequest() async {
    downloaded = false;
    setState(() {});
    try {
      await RestApi.postFriendAction(userId, profileId,
          friendAction: FriendAction.CANCEL_REQUEST);
      await _setProfile();
    } finally {
      downloaded = true;
      if (mounted) setState(() {});
    }
  }

  _onUpdateStatus() async {
    downloaded = false;
    setState(() {});
    try {
      await RestApi.updateStatus(profileId, statusController.text);
      await _setProfile();
    } finally {
      downloaded = true;
      if (mounted) setState(() {});
    }
  }

  _onMessage() {}

  _onEditProfile() {}

  _onFollow() async {
    downloaded = false;
    setState(() {});
    try {
      await RestApi.follow(userId, profileId);
      await _setProfile();
    } finally {
      downloaded = true;
      if (mounted) setState(() {});
    }
  }
}
