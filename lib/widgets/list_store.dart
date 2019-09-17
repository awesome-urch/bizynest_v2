import 'package:bizynest/constants.dart';
import 'package:bizynest/models/store_model.dart';
import 'package:bizynest/pages/negotiate.dart';
import 'package:bizynest/pages/store_page.dart';
import 'package:flutter/material.dart';

class ListViewStores extends StatelessWidget {
  final List<Store> posts;
  static const _navIconSize = 18.0;

  ListViewStores({Key key, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width;

    Widget _topSection(position) {
      Widget row = Row(
        children: <Widget>[
          Image.network(
            AppConstants.BASE_WEBSITE + posts[position].slogo,
            fit: BoxFit.cover, // add this
            height: 50,
            width: 50,
            //height: 100,
          ),
          /*Expanded(
            child: Image.network(
              AppConstants.BASE_WEBSITE + posts[position].slogo,
              fit: BoxFit.cover, // add this
              height: 50,
              width: 50,
              //height: 100,
            ),
          ),*/
          //Image.network(AppConstants.BASE_WEBSITE + posts[position].pphoto),

          Expanded(
            child: Container(
              padding: EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "${posts[position].sname}".toUpperCase(),
                  style: TextStyle(fontSize: 16.0,color: AppConstants.appPurple),
                ),
              ),
            ),
          )


        ],
      );
      return row;
    }

    Widget _ownerSection(position) {
      Widget row = Row(
        children: <Widget>[
          Image.network(
            AppConstants.BASE_WEBSITE + posts[position].slogo,
            fit: BoxFit.cover, // add this
            height: 20,
            width: 20,
            //height: 100,
          ),
          /*Expanded(
            child: Image.network(
              AppConstants.BASE_WEBSITE + posts[position].slogo,
              fit: BoxFit.cover, // add this
              height: 50,
              width: 50,
              //height: 100,
            ),
          ),*/
          //Image.network(AppConstants.BASE_WEBSITE + posts[position].pphoto),

          Expanded(
            child: Container(
              padding: EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "${posts[position].sname}".toUpperCase(),
                  style: TextStyle(fontSize: 16.0,color: AppConstants.appBlue),
                ),
              ),
            ),
          )


        ],
      );
      return row;
    }


      Widget contain01 = GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          /*childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 4),*/
          childAspectRatio: (itemWidth / itemHeight),
        ),
        itemCount: posts.length,
        itemBuilder: (context, position) {
          return SizedBox(
            //height: 600,
            child: GestureDetector(
              onTap: () => _onTapItem(context, posts[position]),
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(4.0),
                      child: _topSection(position),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

      Widget contain0 = GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: posts.length,
        itemBuilder: (context, position) {
          return Image.network(
              AppConstants.BASE_WEBSITE + posts[position].slogo);
        },
      );

      return contain01;
    }
  //}

  void _onTapItem(BuildContext context, Store post) {
    // Scaffold.of(context).removeCurrentSnackBar();
    // Scaffold.of(context).showSnackBar(new SnackBar(
    //   content: new Text(post.product_id.toString() + ' - ' + post.pname),
    // ));
    print('post:');
    print(post);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return StorePage(
          store: post,
        );
      }),
    );
  }
}
