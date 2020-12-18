class Suggestion {
  Suggestion({
    this.title,
    this.thumbnail,
    this.terms,
  });

  String title;
  Thumbnail thumbnail;
  Terms terms;

  factory Suggestion.fromJson(Map<String, dynamic> json) => Suggestion(
        title: json["title"],
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        terms: Terms.fromJson(json["terms"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "thumbnail": thumbnail.toJson(),
        "terms": terms.toJson(),
      };
}

class Terms {
  Terms({
    this.description,
  });

  List<String> description;

  factory Terms.fromJson(Map<String, dynamic> json) => Terms(
        description: List<String>.from(json["description"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "description": List<dynamic>.from(description.map((x) => x)),
      };
}

class Thumbnail {
  Thumbnail({
    this.source,
  });

  String source;
  int width;
  int height;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        source: json == null ? "" : json["source"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "source": source,
      };
}
