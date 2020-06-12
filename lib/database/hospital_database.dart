import 'package:curativecare/models/search_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HospitalDatabase{
// Our database path
  String path;
// Our database once opened
  Database database;

  Future<Database> createDB() async {
    // First version of the database
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    path = join(databasesPath, 'hospital_database.db');
    database= await openDatabase(path,version: 1);
    return database;
  }

   Future<int> createHospitalTable(String name) async {
     int v= (await database.rawQuery('CREATE TABLE ${name} (varchar Description, integer Price, varchar Category)')) as int;
     return v;
  }

   Future<void> InsertData(List<SearchModel> CDM_List) async {

     Batch batch = database.batch();
     CDM_List.forEach((val) {
       //assuming you have 'Cities' class defined
       SearchModel cdm=val;
       batch.insert("data", cdm.toMap());

     });
     await batch.commit();
     //checking
     print(await database.rawQuery('SELECT * FROM a limit 100'));
   }
}