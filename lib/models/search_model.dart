class SearchModel{
  String description,charge,category,name;

  SearchModel(this.description, this.charge, this.category, [this.name]);

  Map<String, dynamic> toMap() {
    return {
      'charge': charge,
      'description': description,
      'category': category,
    };
  }
  SearchModel fromMap(Map<String, dynamic> map){
     map['charge']=charge;
     map['description']=description;
     map['category']=category;
    return SearchModel(description,charge,category);
  }
}