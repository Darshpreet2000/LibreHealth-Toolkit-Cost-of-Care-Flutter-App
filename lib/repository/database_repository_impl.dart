import 'package:curativecare/dao/database_dao.dart';
import 'package:curativecare/models/search_model.dart';
import 'package:curativecare/repository/abstract/database_repository.dart';
import 'package:flutter/material.dart';

class DatabaseRepositoryImpl extends DatabaseRepository {
  final hospitalDao = DatabaseDao();

  @override
  Future getCDM(String tableName) {
    hospitalDao.readData(tableName);
  }

  @override
  Future insertCDM(String tableName, List<SearchModel> cdmList) async {
    //Create a table then insert in it
    await hospitalDao.createHospitalTable(tableName);
     hospitalDao.insertData(tableName, cdmList);
  }
}
