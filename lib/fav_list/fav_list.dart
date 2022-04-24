import 'package:findtrackapp/fav_list/item_fav.dart';
import 'package:flutter/material.dart';

class FavoriteList extends StatefulWidget {
  FavoriteList({Key? key}) : super(key: key);

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            ItemFav(favData: {
              'fav': true,
              'title': 'Burn',
              'picture':
                  'https://i.scdn.co/image/ab67616d0000b273474301b91976f6310bbe90a1',
              'author': 'Ellie Goulding'
            })
          ],
        ),
      ),
    );
  }
}
