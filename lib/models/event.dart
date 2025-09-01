import 'photo.dart';

class Event {
  final String id;
  final String name;
  final String albumThumbnail;
  final String date;
  final String location;
  final List<Photo> photos;

  Event({
    required this.id,
    required this.name,
    required this.albumThumbnail,
    required this.date,
    required this.location,
    required this.photos,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      albumThumbnail: json['albumThumbnail'],
      date: json['date'],
      location: json['location'],
      photos: (json['photos'] as List)
          .map((photo) => Photo.fromJson(photo))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'albumThumbnail': albumThumbnail,
      'date': date,
      'location': location,
      'photos': photos.map((photo) => photo.toJson()).toList(),
    };
  }
}