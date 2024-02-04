class NewsData {
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  NewsData(
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  );
  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
      json['author'],
      json['title'],
      json['description'],
      json['url'],
      json['urlToImage'],
      json['publishedAt'],
      json['content'],
    );
  }
  @override
  String toString() {
    // TODO: implement toString
    if (title != null) {
      return title!;
    }
    return super.toString();
  }
}
