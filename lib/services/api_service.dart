import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import '../core/constants/app_constants.dart';
import '../models/event.dart';

class ApiService {
  final Dio _dio = Dio();
  
  ApiService() {
    _dio.options.baseUrl = AppConstants.baseUrl;
    _dio.options.connectTimeout = AppConstants.connectTimeout;
    _dio.options.receiveTimeout = AppConstants.receiveTimeout;
  }

  Future<bool> mockGoogleSignIn() async {
    await Future.delayed(AppConstants.authDelay);
    return true;
  }

  Future<List<Event>> fetchEvents() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      final String jsonString = await rootBundle.loadString(
        AppConstants.mockDataPath,
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> eventsJson = jsonData['events'];
      
      return eventsJson.map((json) => Event.fromJson(json)).toList();
    } catch (e) {
      throw Exception('${AppConstants.loadingErrorMessage}: $e');
    }
  }

  Future<Event> fetchEventById(String eventId) async {
    try {
      final events = await fetchEvents();
      return events.firstWhere(
        (event) => event.id == eventId,
        orElse: () => throw Exception('Event not found'),
      );
    } catch (e) {
      throw Exception('${AppConstants.loadingErrorMessage}: $e');
    }
  }
}