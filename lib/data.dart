class Data {
  Data({
    this.tags,
  });

  List<Tag> tags;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
      };
}

class Tag {
  Tag({
    this.displayName,
    this.meta,
    this.description,
  });

  String displayName;
  String meta;
  String description;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        displayName: json["displayName"],
        meta: json["meta"] == null ? null : json["meta"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "meta": meta == null ? 'null' : meta,
        "description": description,
      };
}
