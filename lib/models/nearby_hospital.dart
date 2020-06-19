class NearbyHospital {
  String name, distance, beds, operator;
  Future<String> path;

  NearbyHospital(this.name, this.path, this.distance, this.beds,
      [this.operator]);
}
