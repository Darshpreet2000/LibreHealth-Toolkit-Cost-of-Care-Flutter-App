class SearchModel{
  String description,category,name;
  String charge;
  SearchModel(this.description, this.charge, this.category, [this.name]);

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'charge': charge,
      'category': category,
    };
  }
  SearchModel fromMap(Map<String, dynamic> map){
     map['description']=description;
     map['charge']=charge;
     map['category']=category;
    return SearchModel(description,charge,category);
  }
}