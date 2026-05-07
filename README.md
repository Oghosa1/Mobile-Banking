# Mintyn Flutter Assessment

## Project Overview

A dark-themed fintech mobile UI built as a Flutter technical assessment for Mintyn Digital Bank. The app covers four screens: Dashboard (Home), Activity (Transactions), Cards, and Profile.

The architecture is designed so that the mock data layer can be swapped for a real API without modifying any presentation-layer code.

![App Demo](assets/demo.gif)

---

## Architecture

The app follows MVVM (Model-View-ViewModel) with Clean Architecture principles. The goal was to keep each layer independent so that changes in one layer do not break another.

- **Data Layer** — `MockDataService` provides typed models via stream-based providers. Replacing this with a real API only requires implementing the same service contract and overriding the Riverpod provider.
- **ViewModel Layer** — ViewModels handle business logic and expose read-only state to the UI. They consume data from the service layer and process it before the view ever sees it.
- **Presentation Layer** — Views are `ConsumerWidget` or `ConsumerStatefulWidget` instances that listen to ViewModel state. They render state and dispatch user actions — nothing more.

---

## Folder Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_spacing.dart
│   │   └── app_durations.dart
│   └── theme/
│       └── app_theme.dart
├── features/
│   ├── activity/
│   │   └── views/
│   │       └── activity_screen.dart
│   ├── cards/
│   │   ├── views/
│   │   │   └── cards_screen.dart
│   │   └── widgets/
│   │       └── card_slider.dart
│   ├── dashboard/
│   │   ├── views/
│   │   │   └── dashboard_screen.dart
│   │   └── widgets/
│   │       ├── balance_card.dart
│   │       ├── greeting_header.dart
│   │       └── transaction_list.dart
│   └── profile/
│       ├── views/
│       │   └── profile_screen.dart
│       └── widgets/
│           ├── profile_drawer.dart
│           ├── profile_header.dart
│           └── profile_settings_list.dart
├── models/
│   ├── card_model.dart
│   └── transaction_model.dart
├── providers/
│   └── app_providers.dart
├── services/
│   └── mock_data_service.dart
├── shared/
│   └── widgets/
│       └── app_bottom_nav.dart
└── viewmodels/
    ├── cards_viewmodel.dart
    ├── dashboard_viewmodel.dart
    ├── navigation_viewmodel.dart
    └── profile_viewmodel.dart
```

---

## Tech Stack

| Package | Purpose |
|---|---|
| flutter_riverpod | State management and dependency injection |
| fl_chart | Spending chart on the activity screen |
| flutter_svg | SVG rendering for card assets |
| equatable | Value equality on model classes |
| google_fonts | Typography |
| intl | Date and number formatting |

---

## State Management

Riverpod 2.0 is used throughout. A few specific decisions worth noting:

**Navigation** — Bottom navigation index is managed by `NavigationViewModel` which extends `AutoDisposeNotifier<int>`. Rather than using local `setState` inside the bottom bar widget, the navigation state lives in the Riverpod graph. This keeps the state management approach consistent across the entire app and makes navigation transitions testable.

**Profile preferences** — The notification toggle is managed by `ProfileViewModel` and shared between `ProfileScreen` and `ProfileDrawer`. Previously both had independent local state which meant toggling in the drawer would not update the screen. Moving it to a shared ViewModel fixed this.

**Card data** — `CardSlider` was refactored to be a `ConsumerStatefulWidget` that watches `cardsStreamProvider` directly, using Riverpod's `.when()` to handle loading and error states. It previously used a hardcoded local list which bypassed the data layer entirely.

---

## Mock Data

Data is provided through `MockDataService` which returns typed models. The service is registered as a Riverpod provider so it can be overridden in tests or replaced with a real implementation later.

All mock transactions use distinct, realistic timestamps and names to reflect what real data would look like.

---

## Design Decisions and Notes

- The app implements the Figma design as provided. No unrequested features were added.
- Currency formatting follows the Figma design as given. In production this would use locale-aware formatting with the currency symbol preceding the amount.
- User details in mock data reflect the names provided in the Figma design file as given.
- `AppSpacing` and `AppDurations` are kept in separate files from `AppColors` to keep constants files single-responsibility.
- User details in mock data (name, card holder) reflect the values provided in the Figma design file as given.

---

## How to Run

**Requirements**
- Flutter SDK 3.38.9 or higher
- Android emulator or physical device

**Steps**

```bash
# Install dependencies
flutter pub get

# Run tests
flutter test

# Run the app
flutter run
```