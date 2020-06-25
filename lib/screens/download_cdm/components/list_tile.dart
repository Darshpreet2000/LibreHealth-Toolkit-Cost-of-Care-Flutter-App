import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_bloc.dart';
import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_event.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:curativecare/bloc/download_cdm_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'list_tile.dart';

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

ListTile makeListTile(BuildContext context,String hospital) {
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
          onTap: () => {
          context.bloc<DownloadCdmBloc>().add(DownloadCDMGetCSV('Indiana',hospital))
          },
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
