# Main Components

## App Entry and Composition
- `lib/main.dart`: App entry point; initializes Flutter bindings and runs `MyApp`.
- `lib/src/app.dart`: Root widget wiring providers, themes, localization, and `MainScreen`.
- `lib/src/main_screen.dart`: Central router that switches screens based on `GameState`.

## State Management
- `lib/src/game_controller.dart`: Central game state machine, player roster, roles, timer, and round flow.
- `lib/src/monetization/monetization_controller.dart`: Daily quota, ads, in-app purchases, and word selection.
- `lib/src/features/settings/settings_controller.dart`: Theme preferences via shared preferences.

## Feature Screens
- `lib/src/features/onboarding/onboarding_screen.dart`: Onboarding walkthrough.
- `lib/src/features/lobby/lobby_screen.dart`: Player setup, quota display, and game start.
- `lib/src/features/settings/settings_screen.dart`: Game setup (impostors/Mr White) and rules.
- `lib/src/features/game/reveal_screen.dart`: Role reveal and secret word display.
- `lib/src/features/game/turn_screen.dart`: Turn-taking UI and reveal flow.
- `lib/src/features/game/game_screen.dart`: Discussion timer and voting list.
- `lib/src/features/game/round_feedback_screen.dart`: Feedback after elimination.
- `lib/src/features/results/results_screen.dart`: Round results and reset.

## Domain Models and Data
- `lib/src/models/game_state.dart`: Game flow state enum.
- `lib/src/models/player.dart`: Player model.
- `lib/src/models/role.dart`: Role enum.
- `lib/src/models/word_pair.dart`: Word pair + category model.
- `lib/src/data/word_packs.dart`: Locale-specific word lists and categories.

## UI Foundations
- `lib/src/core/theme.dart`: App theme and typography.
- `lib/src/core/grid_background.dart`: Shared grid background painter.
- `lib/src/core/confirm_exit.dart`: Standard confirm dialog for returning to lobby.

## Localization
- `lib/l10n/`: Generated localization classes and ARB files.
- `l10n.yaml`: Localization configuration.

## Assets
- `assets/images/avatars/`: Avatar imagery used in UI.

## Tests
- `test/widget_test.dart`: Basic widget smoke test.

## Platform Targets
- `android/`, `ios/`, `macos/`, `windows/`, `linux/`, `web/`: Platform project scaffolding.

## Primary App Flow
Onboarding → Lobby → Reveal → Turn Taking → Discussion → Voting → Round Feedback → Results
