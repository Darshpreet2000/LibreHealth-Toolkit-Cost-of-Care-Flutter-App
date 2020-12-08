import 'package:cost_of_care/bloc/compare_hospital_bloc/compare_hospital_list/compare_hospital_list_bloc.dart';
import 'package:f_logs/model/flog/flog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'list_tile.dart';
class Body extends StatefulWidget {
  final CompareHospitalListBloc compareHospitalListBloc;

  Body(this.compareHospitalListBloc);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
     return BlocListener(
       cubit: widget.compareHospitalListBloc,
         listener: (BuildContext context, state) {
               if(state is ShowSnackBar){
                 Scaffold.of(context).showSnackBar(SnackBar(
                   content: Text(
                     state.message,
                     style: TextStyle(color: Colors.white),
                   ),
                   backgroundColor: Colors.red,
                 ));
               }
         },
       child: BlocBuilder(
           cubit: widget.compareHospitalListBloc,
           builder: (BuildContext context, CompareHospitalListState state) {
                if(state is LoadingState){
                  return Center(child: CircularProgressIndicator());
                }
                else if( state is LoadedState){
                  FLog.exportLogs();
                  return showList(state.hospitalCompareData,widget.compareHospitalListBloc);
                }

                else if (state is ErrorState){
                  return Center(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Center(child: Text(state.message , style: TextStyle(
                        fontSize: 18,
                      ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,)),
                    ),
                  );
                }
                return CircularProgressIndicator();
           }),
     );
  }

   @override
  void initState() {
     super.initState();
     widget.compareHospitalListBloc.add(GetCompareData());
  }
}

Widget showList(List<List<dynamic>> hospitalsName,  CompareHospitalListBloc compareHospitalListBloc) {
  return Scrollbar(
    child: ListView.builder(
      itemCount: hospitalsName.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 4.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.grey[50]),
            child: makeListTile(context, hospitalsName[index][0],hospitalsName[index][13], index,compareHospitalListBloc),
          ),
        );
      },
    ),
  );
}
