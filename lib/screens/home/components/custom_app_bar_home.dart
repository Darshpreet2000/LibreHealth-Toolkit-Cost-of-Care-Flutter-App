import 'package:flutter/material.dart';

class CustomAppBarHome extends StatelessWidget {
  Color red800 = Colors.red[800];
  @override
  Widget build(BuildContext context) {
    return Ink(
        child: Stack(
          children: <Widget>[
            Ink(
              // Background
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.amber, Colors.deepOrange[600]])),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/logowhite.png',
                      height: 40,
                      width: 50,
                    ),
                    Text(
                      "LibreHealth",
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.19,
              width: MediaQuery.of(context).size.width,
            ),

            Ink(), // Required some widget in between to float AppBar

            Positioned(
              // To take AppBar Size only
                top: 100.0,
                left: 10.0,
                right: 10.0,
                child:InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, '/SearchProcedure');
                  },
                  child:AppBar(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.white,
                    primary: false,
                    leading: IconButton(
                      icon: Icon(Icons.search, color: red800),
                      onPressed: () {  Navigator.pushNamed(context, '/SearchProcedure');
                      },
                    ),
                    title: Text('Search Procedure',
                        style: TextStyle(color: Colors.grey, fontSize: 16.0)),

                  ),
                )

            ),

          ],
        ));
  }
}
