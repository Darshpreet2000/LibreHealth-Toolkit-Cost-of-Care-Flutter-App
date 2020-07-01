class SearchModel {
  String description, category, name;
  String charge;

  SearchModel(this.description, this.charge, this.category, [this.name]);

  SearchModel.empty();

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'charge': charge,
      'category': category,
    };
  }

  SearchModel fromMap(Map<String, dynamic> map) {
    description = map['description'] != null ? map['description'] : "N/A";
    charge = map['charge'] != null ? map['charge'] : "N/A";
    category = map['category'] != null ? map['category'] : "N/A";
    return SearchModel(description, charge, category);
  }
  SearchModel fromMapResult(Map<String, dynamic> map) {
    description = map['description'] != null ? map['description'] : "N/A";
    charge = map['charge'] != null ? map['charge'] : "N/A";
    category = map['category'] != null ? map['category'] : "N/A";
    name = map['name'] != null ? map['name'] : "N/A";
    return SearchModel(description, charge, category, name);
  }
}
