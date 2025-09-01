class Photo {
  final String id;
  final String url;
  final String thumbnailUrl;
  final String caption;
  bool isLiked;

  Photo({
    required this.id,
    required this.url,
    required this.thumbnailUrl,
    required this.caption,
    this.isLiked = false,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
      caption: json['caption'],
      isLiked: json['isLiked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
      'caption': caption,
      'isLiked': isLiked,
    };
  }
}