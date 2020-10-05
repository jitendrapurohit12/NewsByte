class NewsModel {
  String status;
  int totalResults;
  List<Articles> articles;

  NewsModel({this.status, this.totalResults, this.articles});

  NewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as String;
    totalResults = json['totalResults'] as int;
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles.add(Articles.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['totalResults'] = totalResults;
    if (articles != null) {
      data['articles'] = articles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Articles {
  Source source;
  String urlToImage, publishedAt, content, author, title, description, url;

  Articles({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  Articles.fromJson(Map<String, dynamic> json) {
    source = json['source'] != null
        ? Source.fromJson(json['source'] as Map<String, dynamic>)
        : null;
    author = json['author'] as String;
    title = json['title'] as String;
    description = json['description'] as String;
    url = json['url'] as String;
    urlToImage = json['urlToImage'] as String;
    publishedAt = json['publishedAt'] as String;
    content = json['content'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (source != null) {
      data['source'] = source.toJson();
    }
    data['author'] = author;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['publishedAt'] = publishedAt;
    data['content'] = content;
    return data;
  }
}

class Source {
  String id, name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    name = json['name'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
