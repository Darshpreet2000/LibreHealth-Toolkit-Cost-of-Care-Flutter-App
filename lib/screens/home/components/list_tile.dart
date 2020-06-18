import 'package:curativecare/models/nearby_hospital.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Card makeCard(NearbyHospital hospital) {
  return Card(
    elevation: 4.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Colors.grey[50]),
      child: makeListTile(hospital),
    ),
  );
}

Container makeListTile(NearbyHospital hospital) {
  return Container(
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              offset: Offset(-1.0, 1.0),
              blurRadius: 4.0,
              spreadRadius: 1.0)
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10, top: 16, bottom: 16, right: 10),
            width: 100,
            decoration: BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('assets/show.jpg'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          hospital.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Source',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('BEDS', style: TextStyle(fontSize: 14)),
                      Row(
                        children: <Widget>[
                          Text(
                            'DISTANCE',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            width: 8,
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        hospital.beds,
                        style: TextStyle(fontSize: 14),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 45,
                            width: 45,
                            child: Image.asset('assets/distance_icon.png'),
                          ),
                          Text(
                            hospital.distance,
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ))
        ],
      ));
}

Container makeShimmerListTile(BuildContext  context,int index) {
  return Container(
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              offset: Offset(-1.0, 1.0),
              blurRadius: 4.0,
              spreadRadius: 1.0)
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10, top: 16, bottom: 16, right: 10),
            width: 100,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.white,
                      child: Container(
                        height: 15,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:12),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.white,
                      child: Container(
                        height: 15,
                        width: MediaQuery.of(context).size.width/3,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                  )

                ],
              ))
        ],
      ));
}
