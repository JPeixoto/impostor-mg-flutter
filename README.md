# Impostor Game (Flutter)

A multiplayer social deduction game built with Flutter. Players are assigned roles (Civilian, Impostor, or Mr. White) and must deduce who among them is the impostor while trying not to reveal the secret word.

## Features

-   **Multiplayer Gameplay**: Support for local multiplayer with dynamic player roles.
-   **Roles**:
    -   **Civilian**: Knows the secret word. Tries to find the Impostor without revealing the word.
    -   **Impostor**: Gets a different word and tries to blend in.
    -   **Mr. White**: Gets no word and must bluff.
-   **Game Loop**: Lobby -> Role Reveal -> Turn Taking -> Discussion -> Voting -> Results.
-   **Monetization**: Integration for AdMob and In-App Purchases (Word Packs).
-   **Localization**: Supports multiple languages for word packs and UI.

## Prerequisites

-   [Flutter SDK](https://flutter.dev/docs/get-started/install) (Version 3.8.1 or higher recommended)
-   Dart SDK (Included with Flutter)
-   [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)
-   A mobile device or emulator (Android/iOS)

## Getting Started

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd impostor-mg-flutter
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the app:**
    -   Connect a device or start an emulator.
    -   Run the following command:
        ```bash
        flutter run
        ```

## Project Structure

The project follows a feature-first architecture located in `lib/src/`.

-   **`lib/main.dart`**: Application entry point.
-   **`lib/src/app.dart`**: Root widget and provider setup.
-   **`lib/src/game_controller.dart`**: Core game logic and state management.
-   **`lib/src/features/`**: UI screens and widgets organized by feature (game, lobby, settings, etc.).
-   **`lib/src/data/`**: Data sources (Word packs).
-   **`lib/src/monetization/`**: Ads and IAP logic.

## Documentation

For more detailed information, please refer to the documentation in the `doc/` directory:

-   [Architecture Overview](doc/architecture.md)
-   [Project Structure](doc/project_structure.md)
-   [Game Features & Logic](doc/features.md)
-   [Setup & Configuration](doc/setup.md)
