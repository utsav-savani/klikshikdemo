class AppConstants {
  // App Info
  static const String appName = 'Event Album';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Capture and share your memories';
  
  // API
  static const String baseUrl = 'https://api.mockapi.io/v1';
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration connectTimeout = Duration(seconds: 5);
  static const Duration receiveTimeout = Duration(seconds: 3);
  
  // Authentication
  static const Duration authDelay = Duration(seconds: 2);
  static const String googleAuthProvider = 'google.com';
  
  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String themeKey = 'theme_mode';
  
  // Layout
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double extraLargePadding = 32.0;
  
  static const double defaultRadius = 12.0;
  static const double smallRadius = 4.0;
  static const double largeRadius = 16.0;
  static const double circularRadius = 30.0;
  
  static const double defaultElevation = 4.0;
  static const double smallElevation = 2.0;
  static const double largeElevation = 8.0;
  static const double bottomBarHeight = 80.0;
  static const double bottomBarIconHeight = 34.0;
  static const double bottomBarIconWidth = 58.0;

  // Grid Configuration
  static const int gridCrossAxisCount = 6;
  static const double gridSpacing = 4.0;
  static const double gridChildAspectRatio = 1.0;
  static const double likeThumbCircleHeightWidth = 56.0;

  // Image Sizes
  static const double thumbnailHeight = 200.0;
  static const double albumThumbnailHeight = 200.0;
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 20.0;
  static const double iconSizeExtraLarge = 60.0;
  static const double logoSize = 100.0;
  
  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
  
  // Slideshow
  static const Duration slideshowInterval = Duration(seconds: 3);
  static const Duration controlsHideDelay = Duration(seconds: 3);
  
  // Limits
  static const int maxPhotosPerEvent = 100;
  static const int maxEventNameLength = 100;
  static const int maxCaptionLength = 200;
  
  // Error Messages
  static const String genericErrorMessage = 'Something went wrong. Please try again.';
  static const String networkErrorMessage = 'Please check your internet connection.';
  static const String authErrorMessage = 'Authentication failed. Please try again.';
  static const String loadingErrorMessage = 'Failed to load data.';
  static const String noDataMessage = 'No data available.';
  static const String noEventsMessage = 'No events available';
  static const String noPhotosMessage = 'No photos available';
  
  // Success Messages
  static const String loginSuccessMessage = 'Successfully logged in!';
  static const String photoLikedMessage = 'Photo liked!';
  static const String photoUnlikedMessage = 'Like removed';
  
  // Button Labels
  static const String continueWithGoogleLabel = 'Continue with Google';
  static const String retryLabel = 'Retry';
  static const String signOutLabel = 'Sign Out';
  static const String slideshowLabel = 'Slideshow';
  
  // Screen Titles
  static const String authScreenTitle = 'Event Album';
  static const String eventListScreenTitle = 'Assignment App';
  static const String loadingText = 'Loading...';
  static const String signingInText = 'Signing in...';
  
  // Asset Paths
  static const String googleLogoUrl = 'assets/images/google_ic.png';
  static const String eventIconUrl = 'assets/images/event_ic.png';
  static const String profileIconUrl = 'assets/images/profile_ic.png';
  static const String mockDataPath = 'assets/data/mock_events.json';

  // Placeholder URLs (Using Lorem Picsum)
  static const String placeholderImageUrl = 'https://picsum.photos/';
  
  // Date Format
  static const String dateFormat = 'yyyy-MM-dd';
  static const String displayDateFormat = 'MMM dd, yyyy';
}