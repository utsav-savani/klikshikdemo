import 'package:flutter/material.dart';
import 'package:klikshikdemo/screens/bottom_bar_screen.dart';
import '../../models/event.dart';
import '../../screens/auth_screen.dart';
import '../../screens/event_list_screen.dart';
import '../../screens/album_screen.dart';
import '../../screens/photo_view_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.auth:
        return MaterialPageRoute(
          builder: (_) => const AuthScreen(),
        );
        
      case AppRoutes.main:
        return MaterialPageRoute(
          builder: (_) => const BottomBarScreen(),
        );
        
      case AppRoutes.eventList:
        return MaterialPageRoute(
          builder: (_) => const EventListScreen(),
        );
        
      case AppRoutes.album:
        final event = settings.arguments as Event;
        return MaterialPageRoute(
          builder: (_) => AlbumScreen(event: event),
        );
        
      case AppRoutes.photoView:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => PhotoViewScreen(
            event: args['event'] as Event,
            initialIndex: args['initialIndex'] as int,
            isSlideshow: args['isSlideshow'] as bool? ?? false,
          ),
        );
        
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
  
  static void navigateToAuth(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.auth,
      (route) => false,
    );
  }
  
  static void navigateToMain(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(AppRoutes.main);
  }
  
  static void navigateToEventList(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(AppRoutes.eventList);
  }
  
  static void navigateToAlbum(BuildContext context, Event event) {
    Navigator.of(context).pushNamed(
      AppRoutes.album,
      arguments: event,
    );
  }
  
  static void navigateToPhotoView(
    BuildContext context,
    Event event,
    int initialIndex, {
    bool isSlideshow = false,
  }) {
    Navigator.of(context).pushNamed(
      AppRoutes.photoView,
      arguments: {
        'event': event,
        'initialIndex': initialIndex,
        'isSlideshow': isSlideshow,
      },
    );
  }
}