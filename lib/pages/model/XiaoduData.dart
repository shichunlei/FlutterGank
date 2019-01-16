class XianduData {
  String _id;
  String content;
  String cover;
  int crawled;
  String created_at;
  bool deleted;
  String published_at;
  String raw;
  String title;
  String uid;
  String url;
  dynamic site;

  XianduData(
      this._id,
      this.content,
      this.cover,
      this.crawled,
      this.created_at,
      this.deleted,
      this.published_at,
      this.raw,
      this.title,
      this.uid,
      this.url,
      this.site);

  XianduData.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        content = json['content'],
        cover = json['cover'],
        crawled = json['crawled'],
        created_at = json['created_at'],
        deleted = json['deleted'],
        published_at = json['published_at'],
        raw = json['raw'],
        title = json['title'],
        uid = json['uid'],
        url = json['url'],
        site = json['site'];

  Map<String, dynamic> toJson() => {
        '_id': _id,
        'content': content,
        'cover': cover,
        'crawled': crawled,
        'created_at': created_at,
        'deleted': deleted,
        'published_at': published_at,
        'raw': raw,
        'title': title,
        'uid': uid,
        'url': url,
        'site': site,
      };

  @override
  String toString() {
    return 'XianduData{_id: $_id, content: $content, cover: $cover, crawled: $crawled, created_at: $created_at, deleted: $deleted, published_at: $published_at, raw: $raw, title: $title, uid: $uid, url: $url, site: $site}';
  }
}

class Site {
  String cat_cn;
  String cat_en;
  String desc;
  String id;
  String name;
  String type;
  String url;
  String icon;
  String feed_id;
  String subscribers;

  Site.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        cat_cn = json['cat_cn'],
        cat_en = json['cat_en'],
        name = json['name'],
        feed_id = json['feed_id'],
        icon = json['icon'],
        subscribers = json['subscribers'],
        desc = json['desc'],
        url = json['url'],
        type = json['type'];

  Site(this.cat_cn, this.cat_en, this.desc, this.id, this.name, this.type,
      this.url, this.icon, this.feed_id, this.subscribers);

  Map<String, dynamic> toJson() => {
        'id': id,
        'cat_en': cat_en,
        'cat_cn': cat_cn,
        'desc': desc,
        'icon': icon,
        'feed_id': feed_id,
        'subscribers': subscribers,
        'type': type,
        'url': url,
        'name': name,
      };

  @override
  String toString() {
    return 'Site{cat_cn: $cat_cn, cat_en: $cat_en, desc: $desc, id: $id, name: $name, type: $type, url: $url, icon: $icon, feed_id: $feed_id, subscribers: $subscribers}';
  }
}
