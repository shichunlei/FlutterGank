class CategoryData {
  String _id;
  String en_name;
  String name;
  int rank;

  CategoryData(this._id, this.en_name, this.name, this.rank);

  CategoryData.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        en_name = json['en_name'],
        name = json['name'],
        rank = json['rank'];

  @override
  String toString() {
    return 'CategoryData{_id: $_id, en_name: $en_name, name: $name, rank: $rank}';
  }

  Map<String, dynamic> toJson() => {
        '_id': _id,
        'en_name': en_name,
        'name': name,
        'rank': rank,
      };
}

class SubCategory {
  String _id;
  String id;
  String title;
  String icon;
  String created_at;

  SubCategory(this._id, this.id, this.title, this.icon, this.created_at);

  SubCategory.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        title = json['title'],
        id = json['id'],
        icon = json['icon'],
        created_at = json['created_at'];

  @override
  String toString() {
    return 'SubCategory{_id: $_id, id: $id, title: $title, icon: $icon, created_at: $created_at}';
  }

  Map<String, dynamic> toJson() => {
        '_id': _id,
        'title': title,
        'id': id,
        'icon': icon,
        'created_at': created_at,
      };
}
