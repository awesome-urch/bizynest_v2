import 'package:bizynest/constants.dart';
import 'package:bizynest/models/top_store_model.dart';
import 'package:bizynest/models/store_model.dart';
import 'package:bizynest/pages/negotiate.dart';
import 'package:bizynest/pages/store_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

class ListViewStores extends StatelessWidget {
  final List<TopStore> posts;
  static const _navIconSize = 18.0;
  static const _navIconSize2 = 22.0;
  static const _loveIconSize = 45.0;

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
          /*Image.network(
            AppConstants.BASE_WEBSITE + posts[position].slogo,
            fit: BoxFit.cover, // add this
            height: 50,
            width: 50,
            //height: 100,
          ),*/
          FadeInImage.assetNetwork(
            placeholder: 'images/default_image.jpg',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            image: AppConstants.BASE_WEBSITE + posts[position].slogo,
          ),
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
          /*Image.network(
            AppConstants.BASE_WEBSITE + posts[position].picture,
            fit: BoxFit.cover, // add this
            height: 20,
            width: 20,
            //height: 100,
          ),*/
          FadeInImage.assetNetwork(
            placeholder: 'images/default_image.jpg',
            width: 20,
            height: 20,
            fit: BoxFit.cover,
            image: AppConstants.BASE_WEBSITE + posts[position].picture,
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "${posts[position].surname} ${posts[position].firstname}",
                  style: TextStyle(fontSize: 12.0,color: AppConstants.appBlue),
                ),
              ),
            ),
          )


        ],
      );
      return row;
    }

    Widget _divider = Container(
          child: Divider(
            color: Colors.grey[300],
          ),
    );

    var _starsArray = [
      Icon(
        Icons.star,
        size: _navIconSize,
        color: Colors.grey[500],
      ),
      Icon(
        Icons.star,
        size: _navIconSize,
        color: Colors.grey[500],
      ),
      Icon(
        Icons.star,
        size: _navIconSize,
        color: Colors.grey[500],
      ),
      Icon(
        Icons.star,
        size: _navIconSize,
        color: Colors.grey[500],
      ),
      Icon(
        Icons.star,
        size: _navIconSize,
        color: Colors.grey[500],
      ),
    ];

    _starSectionArray(position){
      var stars = posts[position].stars;
      var val = 0;
      double averageSum = 0;
      if(stars !=null && stars!="null"){
        var array = stars.split(",");
        double len = array.length * 1.0;
        double sum = 0;
        for(var i in array){
          sum = sum + int.parse(i.trim());
        }
        //averageSum = double.parse(sum)/double.parse(len);
        averageSum = sum/len;
      }

      var iconGreen = Icon(
        Icons.star,
        size: _navIconSize,
        color: Colors.green[500],
      );

      var iconArr = _starsArray;

      print(averageSum);

      /*iconArr[0] = iconGreen;
      print(stars);*/

      if(averageSum < 6){
        for(var i = 0; i < averageSum; i++){
          iconArr[i] = iconGreen;
        }
      }

      /*Icon retn;

      for(var x in starsArray){
        retn = retn + x;
      }*/

      return iconArr;

    }

    Widget _bottomSection(position){
      return Container(
        padding: EdgeInsets.all(4.0),
        child: Row(
          children: [
            Icon(
              Icons.favorite_border,
              size: _loveIconSize,
              color: Colors.grey[500],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.textsms,
                                  size: _navIconSize2,
                                ),
                                Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(28.0, 0.0, 0.0, 0.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.remove_red_eye,
                                  size: _navIconSize2,
                                ),
                                Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      '${posts[position].views}',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(28.0, 0.0, 0.0, 0.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.person,
                                  size: _navIconSize2,
                                ),
                                Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    )
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child:
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Ratings',
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            Container(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                                child: Row(
                                  children: <Widget>[
                                    _starSectionArray(position)[0],
                                    _starSectionArray(position)[1],
                                    _starSectionArray(position)[2],
                                    _starSectionArray(position)[3],
                                    _starSectionArray(position)[4],
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }


      Widget contain01 = GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          /*childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 4),*/
          childAspectRatio: (itemWidth / itemHeight),
        ),
        itemCount: posts.length,
        itemBuilder: (context, position) {
          return SizedBox(
            //height: 600,
            child: GestureDetector(
              //onTap: () => _onTapItem(context, posts[position]),
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => _onTapItem(context, posts[position]),
                        child: _topSection(position),
                      )
                      //_topSection(position),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: _ownerSection(position),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: _divider,
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: _bottomSection(position),
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

  void _onTapItem(BuildContext context, TopStore post) {
    // Scaffold.of(context).removeCurrentSnackBar();
    // Scaffold.of(context).showSnackBar(new SnackBar(
    //   content: new Text(post.product_id.toString() + ' - ' + post.pname),
    // ));
    print('post:');
    print(post);

    Store store = new Store();
    store.sname = post.sname;
    store.store_id = post.store_id;
    store.store_uid = post.store_uid;

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return StorePage(
          store: store,
        );
      }),
    );
  }
}
