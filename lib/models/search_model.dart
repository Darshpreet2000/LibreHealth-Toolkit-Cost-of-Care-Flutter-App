class SearchModel{
  String description,charge,category,name;

  SearchModel(this.description, this.charge, this.category, this.name);

  Map<String, dynamic> toMap() {
    return {
      'price': charge,
      'description': description,
      'charge_type': category,
    };
  }
}