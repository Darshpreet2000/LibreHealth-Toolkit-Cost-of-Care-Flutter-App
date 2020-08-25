import 'package:cached_network_image/cached_network_image.dart';
import 'package:cost_of_care/models/hospitals.dart';
import 'package:cost_of_care/repository/nearby_hospital_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Card makeCard(Hospitals hospital) {
  return Card(
    elevation: 4.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Colors.grey[50]),
      child: MakeListTile(hospital),
    ),
  );
}

class MakeListTile extends StatefulWidget {
  final Hospitals hospital;

  MakeListTile(this.hospital);

  @override
  _MakeListTileState createState() => _MakeListTileState();
}

class _MakeListTileState extends State<MakeListTile> {
  NearbyHospitalsRepoImpl nearbyHospitalsRepository =
      new NearbyHospitalsRepoImpl();

  @override
  Widget build(BuildContext context) {
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
            FutureBuilder(
              future: imageFuture,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    margin: EdgeInsets.only(
                        left: 10, top: 16, bottom: 16, right: 10),
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: new FittedBox(
                        fit: BoxFit.fill,
                        child: Image.asset('assets/placeholder.png')),
                  );
                } else if (snapshot.hasData) {
                  return CachedNetworkImage(
                    imageUrl: snapshot.data,
                    imageBuilder: (context, imageProvider) => Container(
                      margin: EdgeInsets.only(
                          left: 10, top: 16, bottom: 16, right: 10),
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                        margin: EdgeInsets.only(
                            left: 10, top: 16, bottom: 16, right: 10),
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(),
                        )),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  );
                }
                return Container(
                  margin:
                      EdgeInsets.only(left: 10, top: 16, bottom: 16, right: 10),
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
                );
              },
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    widget.hospital.name,
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
                      widget.hospital.beds,
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
                          widget.hospital.distance + " km",
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

  Future imageFuture;

  @override
  void initState() {
    super.initState();
    imageFuture = nearbyHospitalsRepository.fetchImages(widget.hospital.name);
  }
}

Container makeShimmerListTile(BuildContext context, int index) {
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
                padding: const EdgeInsets.only(left: 12),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.white,
                  child: Container(
                    height: 15,
                    width: MediaQuery.of(context).size.width / 3,
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
