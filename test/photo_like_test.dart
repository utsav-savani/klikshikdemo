import 'package:flutter_test/flutter_test.dart';
import 'package:klikshikdemo/models/event.dart';
import 'package:klikshikdemo/models/photo.dart';
import 'package:klikshikdemo/providers/event_provider.dart';

void main() {
  group('Photo Like Functionality', () {
    test('Photo isLiked should toggle correctly', () {
      final photo = Photo(
        id: 'test_photo_1',
        url: 'https://example.com/photo.jpg',
        thumbnailUrl: 'https://example.com/thumb.jpg',
        caption: 'Test Photo',
        isLiked: false,
      );

      expect(photo.isLiked, false);

      photo.isLiked = true;
      expect(photo.isLiked, true);

      photo.isLiked = false;
      expect(photo.isLiked, false);
    });

    test('EventProvider togglePhotoLike should toggle photo like status', () {
      final eventProvider = EventProvider();

      final photos = [
        Photo(
          id: 'p1',
          url: 'https://example.com/photo1.jpg',
          thumbnailUrl: 'https://example.com/thumb1.jpg',
          caption: 'Photo 1',
          isLiked: false,
        ),
        Photo(
          id: 'p2',
          url: 'https://example.com/photo2.jpg',
          thumbnailUrl: 'https://example.com/thumb2.jpg',
          caption: 'Photo 2',
          isLiked: false,
        ),
      ];

      final event = Event(
        id: 'event1',
        name: 'Test Event',
        albumThumbnail: 'https://example.com/album.jpg',
        date: '2024-01-01',
        location: 'Test Location',
        photos: photos,
      );

      eventProvider.events.add(event);

      expect(eventProvider.events[0].photos[0].isLiked, false);

      eventProvider.togglePhotoLike('event1', 'p1');
      expect(eventProvider.events[0].photos[0].isLiked, true);

      eventProvider.togglePhotoLike('event1', 'p1');
      expect(eventProvider.events[0].photos[0].isLiked, false);

      eventProvider.togglePhotoLike('event1', 'p2');
      expect(eventProvider.events[0].photos[1].isLiked, true);
    });

    test('Photo fromJson and toJson should work correctly', () {
      final json = {
        'id': 'test_id',
        'url': 'https://example.com/photo.jpg',
        'thumbnailUrl': 'https://example.com/thumb.jpg',
        'caption': 'Test Caption',
        'isLiked': true,
      };

      final photo = Photo.fromJson(json);

      expect(photo.id, 'test_id');
      expect(photo.url, 'https://example.com/photo.jpg');
      expect(photo.thumbnailUrl, 'https://example.com/thumb.jpg');
      expect(photo.caption, 'Test Caption');
      expect(photo.isLiked, true);

      final exportedJson = photo.toJson();
      expect(exportedJson['id'], 'test_id');
      expect(exportedJson['url'], 'https://example.com/photo.jpg');
      expect(exportedJson['thumbnailUrl'], 'https://example.com/thumb.jpg');
      expect(exportedJson['caption'], 'Test Caption');
      expect(exportedJson['isLiked'], true);
    });
  });
}
