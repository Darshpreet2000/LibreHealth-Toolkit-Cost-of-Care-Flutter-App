import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarHome extends StatelessWidget {
  final GlobalKey<ScaffoldState> drawerKey;
  final userLocationWidget;

  AppBarHome(this.drawerKey, this.userLocationWidget);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      decoration: BoxDecoration(
        color: Colors.grey[100],
      ),
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 35),
        decoration: BoxDecoration(
            color: Colors.grey[50],
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0,
              ),
            ],
            border: Border.all(
              color: Colors.grey[100],
            ),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () {
                drawerKey.currentState.openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.black,
                size: 25,
              ),
            ),
            Expanded(
                child: InkWell(
              onTap: () => {Navigator.pushNamed(context, '/SearchProcedure')},
              child: Text(
                'Search for Procedures, Pharmacy, DRG',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            )),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/SettingsHome',
                    arguments: userLocationWidget);
              },
            )
          ],
        ),
      ),
    );
  }
}
