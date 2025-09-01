import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/api_service.dart';

class EventProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  List<Event> _events = [];
  Event? _selectedEvent;
  bool _isLoading = false;
  String? _error;

  List<Event> get events => _events;
  Event? get selectedEvent => _selectedEvent;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchEvents() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _events = await _apiService.fetchEvents();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _events = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> selectEvent(String eventId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _selectedEvent = await _apiService.fetchEventById(eventId);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _selectedEvent = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void togglePhotoLike(String eventId, String photoId) {
    final eventIndex = _events.indexWhere((e) => e.id == eventId);
    if (eventIndex != -1) {
      final photoIndex = _events[eventIndex].photos.indexWhere((p) => p.id == photoId);
      if (photoIndex != -1) {
        _events[eventIndex].photos[photoIndex].isLiked = 
            !_events[eventIndex].photos[photoIndex].isLiked;
        
        if (_selectedEvent?.id == eventId) {
          final selectedPhotoIndex = 
              _selectedEvent!.photos.indexWhere((p) => p.id == photoId);
          if (selectedPhotoIndex != -1) {
            _selectedEvent!.photos[selectedPhotoIndex].isLiked = 
                !_selectedEvent!.photos[selectedPhotoIndex].isLiked;
          }
        }
        
        notifyListeners();
      }
    }
  }

  void clearSelectedEvent() {
    _selectedEvent = null;
    notifyListeners();
  }
}