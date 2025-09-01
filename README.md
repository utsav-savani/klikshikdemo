# Event Album App

A Flutter application for viewing and managing event photo albums with Google authentication simulation, built as part of the Klikshik Flutter Developer Assignment.

## Features

### Authentication
- **Google Sign-In Simulation**: Mock authentication with loading indicator
- Clean and modern authentication UI with gradient background
- Automatic navigation to event list after successful login

### Event Management
- **Event List Screen**: Scrollable list of events with thumbnails
- **Pull-to-Refresh**: Refresh event list with swipe gesture
- **Event Details**: Display event name and thumbnail (location, date, photo count commented out)
- **Error Handling**: Error states with retry functionality

### Photo Album Features
- **Grid View**: 6-column photo grid for each event album
- **Photo Viewer**: Full-screen photo viewing with pinch-to-zoom
- **Like Functionality**: Button to like/unlike photos (with haptic feedback)
- **Photo Navigation**: Swipe or arrow buttons to navigate between photos
- **Photo Information**: Display photo captions and like status

### Bonus Features
- **Slideshow Mode**: 
  - Automatic photo progression (3-second intervals)
  - Play/pause controls
  - Smooth transitions between photos
  - Access from album screen via slideshow button
- **Interactive Controls**: Hide/show controls with tap gesture
- **Hero Animations**: Smooth transitions between grid and full view
- **Haptic Feedback**: Tactile response on like action

## Tech Stack

- **Framework**: Flutter 3.35.1 (managed with FVM)
- **State Management**: Provider (^6.1.1)
- **HTTP Client**: Dio (^5.4.0)
- **Image Caching**: cached_network_image (^3.3.1)
- **Architecture**: MVVM with Provider pattern
- **Testing**: Flutter Test framework

## Clean Architecture Structure

```
lib/
├── main.dart                    # App entry point
├── core/                        # Core functionality
│   ├── constants/
│   │   └── app_constants.dart   # App-wide constants
│   ├── router/
│   │   ├── app_router.dart      # Route generation
│   │   └── app_routes.dart      # Route definitions
│   ├── theme/
│   │   ├── app_colors.dart      # Color palette
│   │   ├── app_text_styles.dart # Typography
│   │   └── app_theme.dart       # Theme configuration
│   └── utils/
│       ├── extensions.dart      # Dart extensions
│       └── validators.dart      # Form validators
├── models/                      # Data models
│   ├── event.dart              # Event model
│   └── photo.dart              # Photo model
├── providers/                   # State management
│   ├── auth_provider.dart      # Authentication state
│   └── event_provider.dart     # Event and photo state
├── screens/                     # UI screens
│   ├── auth_screen.dart        # Authentication
│   ├── event_list_screen.dart  # Event listing
│   ├── album_screen.dart       # Photo grid
│   └── photo_view_screen.dart  # Photo viewer
├── services/                    # Business logic
│   └── api_service.dart        # API service
└── assets/                      # Static resources
    └── data/
        └── mock_events.json    # Mock data
```

## Setup Instructions

### Prerequisites
- FVM (Flutter Version Manager)
- Flutter SDK 3.35.1 (managed via FVM)
- Dart SDK
- iOS Simulator/Android Emulator or physical device

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd klikshikdemo
```

2. Install dependencies:
```bash
fvm flutter pub get
```

3. Run the app:
```bash
fvm flutter run
```

### Running Tests

Execute the unit tests:
```bash
fvm flutter test
```

The test suite includes:
- Photo like toggle functionality
- Event provider state management
- Photo model serialization/deserialization

## Mock API Details

The app uses local JSON data to simulate API responses. The mock data is stored in `assets/data/mock_events.json` and includes:

- 5 sample events with different themes
- Each event contains 3-6 photos
- Photos are fetched from Lorem Picsum (https://picsum.photos) for realistic placeholders
- Mock authentication delay of 2 seconds to simulate network request

### Data Structure

```json
{
  "events": [
    {
      "id": "string",
      "name": "string",
      "albumThumbnail": "string (URL)",
      "date": "string (YYYY-MM-DD)",
      "location": "string",
      "photos": [
        {
          "id": "string",
          "url": "string (URL)",
          "thumbnailUrl": "string (URL)",
          "caption": "string",
          "isLiked": boolean
        }
      ]
    }
  ]
}
```

## Key Implementation Details

### Clean Architecture
- **Core Layer**: Theme, constants, utilities, and routing
- **Data Layer**: Models with JSON serialization
- **Business Layer**: Services for API interactions
- **Presentation Layer**: Providers for state management and UI screens
- **Separation of Concerns**: Each layer has distinct responsibilities

### State Management
- Uses Provider pattern for centralized state management
- Separate providers for authentication and event data
- Reactive UI updates using ChangeNotifier
- Immutable data models with proper state updates

### Theme System
- **Centralized Theming**: Light and dark theme support
- **Color System**: Consistent color palette across the app
- **Typography**: Standardized text styles using Material 3
- **Constants**: App-wide constants for spacing, durations, and sizes

### Performance Optimizations
- Image caching with cached_network_image
- Hero animations for smooth transitions
- Efficient grid rendering with builder pattern
- Memory management with proper disposal

### Error Handling
- Network error handling with retry button
- Loading states for all async operations
- User-friendly error messages
- Graceful fallbacks for image loading failures
- Basic exception handling in providers

### UI/UX Considerations
- Material Design 3 theming
- Intuitive gestures (swipe, pinch, tap)
- Visual feedback for user actions (haptic feedback, snackbars)
- Smooth animations and transitions
- Auto-hiding controls in photo viewer

## Future Enhancements

- Real API integration with actual backend
- User profile and settings
- Photo upload functionality
- Social features (comments, sharing)
- Advanced filtering and search
- Offline mode with local database
- Push notifications for new photos
- Photo editing capabilities

## Testing

The app includes unit tests for core functionality:
- Photo like/unlike operations
- Provider state management
- Model serialization

Run tests with coverage:
```bash
fvm flutter test --coverage
```

## Download APK

Download the latest Android APK: [Event Album APK](https://drive.google.com/file/d/1S2NrdUFBKU5jfb4PLoYiAxwqSCyoTbh8/view?usp=sharing)

## Build and Deployment

### Android
```bash
fvm flutter build apk --release
```

### iOS
```bash
fvm flutter build ios --release
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is created as part of the Klikshik Flutter Developer Assignment.

## Contact

For any questions or feedback, please reach out to the development team.

---
