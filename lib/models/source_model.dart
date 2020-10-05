class SourceModel {
  String status;
  List<Sources> sources;

  SourceModel({this.status, this.sources});

  SourceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as String;
    if (json['sources'] != null) {
      sources = <Sources>[];
      json['sources'].forEach((v) {
        sources.add(Sources.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (sources != null) {
      data['sources'] = sources.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sources {
  String id, name, description, url, category, language, country;

  Sources(
      {this.id,
      this.name,
      this.description,
      this.url,
      this.category,
      this.language,
      this.country});

  Sources.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    name = json['name'] as String;
    description = json['description'] as String;
    url = json['url'] as String;
    category = json['category'] as String;
    language = json['language'] as String;
    country = json['country'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['url'] = url;
    data['category'] = category;
    data['language'] = language;
    data['country'] = country;
    return data;
  }
}
