class BaseData {
  List<dynamic> category;
  bool error;
  List<dynamic> results;
  int count;

  BaseData(this.category, this.error, this.results, this.count);

  BaseData.fromJson(Map<String, dynamic> json)
      : error = json['error'],
        category = json['category'],
        results = json['results'],
        count = json['count'];

  @override
  String toString() {
    return '{category: $category, error: $error, results: $results, count: $count}';
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'category': category,
        'results': results,
        'count': count,
      };
}

class BaseData2 {
  List<dynamic> category;
  bool error;
  Map<String, dynamic> results;

  BaseData2(this.category, this.error, this.results);

  BaseData2.fromJson(Map<String, dynamic> json)
      : error = json['error'],
        category = json['category'],
        results = json['results'];

  @override
  String toString() {
    return '{category: $category, error: $error, results: $results}';
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'category': category,
        'results': results,
      };
}
