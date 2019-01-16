class SearchData {
  String ganhuo_id;
  String publishedAt;
  String desc;
  String readability;
  String type;
  String url;
  String who;

  SearchData(this.ganhuo_id, this.publishedAt, this.desc, this.readability,
      this.type, this.url, this.who);

  SearchData.fromJson(Map<String, dynamic> json) {
    this.ganhuo_id = json['ganhuo_id'];
    this.publishedAt = json['publishedAt'];
    this.desc = json['desc'];
    this.readability = json['readability'];
    this.type = json['type'];
    this.url = json['url'];
    this.who = json['who'];
  }

  Map<String, dynamic> toJson() => {
        'ganhuo_id': ganhuo_id,
        'publishedAt': publishedAt,
        'desc': desc,
        'readability': readability,
        'type': type,
        'url': url,
        'who': who,
      };

  @override
  String toString() {
    return 'SearchData{ganhuo_id: $ganhuo_id, publishedAt: $publishedAt, desc: $desc, readability: $readability, type: $type, url: $url, who: $who}';
  }
}
