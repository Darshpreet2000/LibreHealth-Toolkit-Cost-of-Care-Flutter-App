import 'package:hive/hive.dart';

part 'hospitals.g.dart';

@HiveType(typeId: 0)
class Hospitals {
  @HiveField(0)
  String name;
  @HiveField(1)
  String distance;
  @HiveField(2)
  String beds;
  @HiveField(3)
  String operator;
  @HiveField(4)
  Future<String> path;

  Hospitals(this.name, this.path, this.distance, this.beds, [this.operator]);
}
