import 'package:curativecare/models/search_model.dart';
import 'package:flutter/material.dart';

//Dummy Data
List<SearchModel> procedures_list=[SearchModel('ROOM/BED: Newborn Routine','3172.4','Standard','UCLA Medical Center'),SearchModel('Lung Transplant','4000','DRG','UCLA Medical Center'),SearchModel('Heart Failure','5800','DRG','University of Michigan'),
  SearchModel('Kidney Transplant Paired Donor','20008','DRG','Alaska Regional Medical Center'),SearchModel('ALTEPLASE 100MG SOLR 1 EACH VIAL','3801.76','Pharmacy','Alaska Regional Medical Center')];

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: procedures_list.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(index);
      },
    );
  }
}

Card makeCard(int index){
  return Card(
    elevation: 4.0,

    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(

      decoration: BoxDecoration(color: Colors.grey[50]),
      child: makeListTile(index),
    ),
  );
}

ListTile makeListTile(int index) {
  return  ListTile(
    title:   Text(procedures_list[index].desciption,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
    subtitle: Text(procedures_list[index].category+'\n'+procedures_list[index].name,style: TextStyle(fontSize: 16),),
    isThreeLine: true,
    trailing: Text(procedures_list[index].charge+' \$',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),

  );
}
