import 'package:bizynest/models/category_model.dart';
import 'package:flutter/material.dart';

class ListViewCategories extends StatefulWidget {
  final ValueChanged<List<MyCategory>> onChanged;
  final List<MyCategory> interests;
  final List<MyCategory> selectedInterests;

  ListViewCategories({
    Key key,
    @required this.interests,
    @required this.selectedInterests,
    @required this.onChanged,
  }) : super(key: key);

  @override
  _ListViewCategoriesState createState() => _ListViewCategoriesState();
}

class _ListViewCategoriesState extends State<ListViewCategories> {
  _handleTap(MyCategory interest, value) {
    setState(() {
      interest.checked = value;
    });

    if (interest.checked)
      widget.selectedInterests.add(interest);
    else
      widget.selectedInterests.remove(interest);

    widget.onChanged(widget.selectedInterests);
  }

  @override
  Widget build(BuildContext context) {
    // return Text('holy');
    return contain2(interests: widget.interests);

    // Widget contain1 = Container(
    //   child: ListView.builder(
    //       itemCount: widget.posts.length,
    //       padding: const EdgeInsets.all(15.0),
    //       itemBuilder: (context, position) {
    //         return Column(
    //           children: <Widget>[
    //             Divider(height: 5.0),
    //             ListTile(
    //               title: Text(
    //                 '${widget.posts[position].name}',
    //                 style: TextStyle(
    //                   fontSize: 22.0,
    //                   color: Colors.deepOrangeAccent,
    //                 ),
    //               ),
    //               subtitle: Text(
    //                 '${widget.posts[position].name}',
    //                 style: new TextStyle(
    //                   fontSize: 18.0,
    //                   fontStyle: FontStyle.italic,
    //                 ),
    //               ),
    //               leading: Column(
    //                 children: <Widget>[
    //                   CircleAvatar(
    //                     backgroundColor: Colors.blueAccent,
    //                     radius: 35.0,
    //                     child: Text(
    //                       'User ${widget.posts[position].id}',
    //                       style: TextStyle(
    //                         fontSize: 22.0,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                   )
    //                 ],
    //               ),
    //               // onTap: () => _onTapItem(context, widget.posts[position]),
    //             ),
    //           ],
    //         );
    //       }),
    // );
  }

  // Widget _setView() => contain2();

  Widget contain2({@required List<MyCategory> interests}) {
    // return Text('here');
    return ListView.builder(
      itemCount: interests.length,
      // padding: const EdgeInsets.all(15.0),
      itemBuilder: (context, position) {
        var interest = interests[position];
        return Column(
          children: <Widget>[
            Divider(height: 1.0),
            CheckboxListTile(
              value: interest.checked,
              onChanged: (value) {
                _handleTap(interest, value);
              },
              title: Text(
                // 'delete moi',
                interest.name,
                style: TextStyle(color: Colors.white),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            )
          ],
        );
      },
    );
  }

  void _onTapItem(BuildContext context, Map post) {
    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(post['id'].toString() + ' - ' + post['name'])));
  }
}
