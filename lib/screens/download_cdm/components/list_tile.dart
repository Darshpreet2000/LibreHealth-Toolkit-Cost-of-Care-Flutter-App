import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

ListTile makeShimmerListTile() {
  return ListTile(
    title: Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.white,
      child: Container(
        height: 20,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    ),
  );
}

ListTile makeListTile(String hospital) {
  return ListTile(
    title: Text(
      hospital,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Source',
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    ),
    trailing: Material(
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          splashColor: Colors.blue,
          borderRadius: BorderRadius.circular(20.0),
          onTap: () => {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.file_download,
              color: Colors.indigo,
              size: 32,
            ),
          ),
        )),
  );
}
