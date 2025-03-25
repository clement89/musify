
<img width="317" alt="Screenshot 2025-03-25 at 11 52 52 PM" src="https://github.com/user-attachments/assets/5ed17190-61de-4530-b814-be030810c5b5" />  

<img width="317" alt="Screenshot 2025-03-26 at 12 00 50 AM" src="https://github.com/user-attachments/assets/f164c29e-20ee-49d3-bdfc-0b6bcf81047d" />

<img width="317" alt="Screenshot 2025-03-26 at 12 01 53 AM" src="https://github.com/user-attachments/assets/50fe0eba-54f9-4536-b01a-28aee3998678" />

# Musify App

## Overview
Musify is a music streaming app that allows users to browse and play songs, manage a cart, and view detailed song information. The app follows a modular architecture with a clean separation of concerns, making it scalable and maintainable.

## Features
- Fetch and display top 20 songs from an API
- Play and pause songs with audio playback support
- Add or remove songs from the cart
- View song details with album cover, artist info, and playback controls
- Pull-to-refresh functionality for song lists
- Centralized error handling for network and unexpected errors
- Multiple flavor support (e.g., Dev, Staging, Production)
- Local storage using `flutter_secure_storage`
- Unit and widget testing for reliability

## Architecture Pattern
Musify follows **Clean Architecture** and **Bloc (Business Logic Component) for State Management**.

### Why Clean Architecture?
- **Separation of Concerns:** Divides app logic into layers (Data, Domain, and Presentation)
- **Scalability:** Easy to modify or add new features without affecting other parts of the codebase
- **Testability:** Each layer can be unit tested independently
- **Interchangeability:** Easily swap Firebase authentication with API-based authentication

## Folder Structure
```
lib/
│── core/
│   ├── exceptions/        # Centralized error handling
│   ├── extensions/        # Custom extension methods
│   ├── theme/             # Theme configurations
│   ├── utils/             # Helper methods
│── modules/
│   ├── splash/            # Splash screen
│   ├── songs/             # Songs feature module
│   │   ├── data/          # Data layer (repositories, models, APIs)
│   │   ├── domain/        # Domain layer (use cases, entities, repositories interfaces)
│   │   ├── presentation/  # UI layer (Bloc, Screens, Widgets)
│── services/
│   ├── audio/             # Audio playback service
│   ├── navigation/        # Navigation service
│── main.dart              # App entry point
```

## Packages Used
| Package                 | Purpose |
|-------------------------|---------|
| flutter_bloc            | State management (Bloc) |
| get_it                  | Dependency Injection |
| flutter_secure_storage  | Secure local storage |
| badges                  | Badge indicators for cart |
| cached_network_image    | Optimized image loading |
| flutter_screenutil      | Responsive UI design |
| equatable               | Value comparison for Bloc state |
| bloc_test               | Unit testing for Bloc |

## Multiple Flavors Implementation
Musify supports multiple flavors: **Development and Production**. This is achieved using **Flutter's flavor configuration**.

### Steps to Run Different Flavors
```sh
# Run Development flavor
flutter run --flavor dev -t lib/main_dev.dart

# Run Production flavor
flutter run --flavor prod -t lib/main_prod.dart
```

Each flavor has its own API base URL and configuration, making it easier to manage different environments.

## Centralized Error Handling
Errors are managed using a dedicated `AppException` class. This allows handling different error types such as:
- **Network Errors** (e.g., No Internet Connection)
- **Timeout Errors** (e.g., API request timeout)
- **Unexpected Errors** (e.g., Unknown failures)

Each error is mapped to a user-friendly message using localization (`context.loc`).

## Unit & Widget Testing
The app includes **unit tests for business logic** and **widget tests for UI components**.

### Example Unit Test for `SongsBloc`
```dart
group('SongsBloc Tests', () {
  blocTest<SongsBloc, SongsState>(
    'emits [progress, loaded] when FetchSongs is called',
    build: () => SongsBloc(useCase: mockUseCase, navigationService: mockNavService),
    act: (bloc) => bloc.add(FetchSongs()),
    expect: () => [
      SongsState.initial().copyWith(status: Status.progress),
      SongsState.initial().copyWith(status: Status.loaded, feed: mockFeed),
    ],
  );
});
```

## Conclusion
Musify is designed with **Clean Architecture**, **Bloc for state management**, and **dependency injection** for scalability. With **secure local storage**, **centralized error handling**, and **extensive testing**, the app is optimized for performance and maintainability.

Happy Coding! 🎵🚀

