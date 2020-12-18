class PageResult {
  PageResult({
    this.pageid,
    this.ns,
    this.title,
    this.extract,
    this.thumbnail,
    this.pageimage,
  });

  int pageid;
  int ns;
  String title;
  String extract;
  Thumbnail thumbnail;
  String pageimage;

  factory PageResult.fromJson(Map<String, dynamic> json) => PageResult(
        pageid: json["pageid"],
        ns: json["ns"],
        title: json["title"],
        extract: json["extract"],
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        pageimage: json["pageimage"],
      );

  Map<String, dynamic> toJson() => {
        "pageid": pageid,
        "ns": ns,
        "title": title,
        "extract": extract,
        "thumbnail": thumbnail.toJson(),
        "pageimage": pageimage,
      };
}

class Thumbnail {
  Thumbnail({
    this.source,
  });

  String source;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        source: json == null ? "" : json["source"],
      );

  Map<String, dynamic> toJson() => {
        "source": source,
      };
}
