# packlite

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# PackLite

PackLite is a smart travel packing assistant built using Flutter.
It helps travelers organize packing lists, manage trips, and get weather-based packing suggestions.

---

## Features

* Trip Management
  Create and manage personal or group trips.

* Packing Checklist
  Select items from a catalog and track packed items in a suitcase view.

* Packing Progress
  Visual progress indicator showing how many items are packed.

* Weather Check
  Check the weather of your destination before packing.

* Temperature Based Suggestions
  The app suggests travel items based on the temperature:

  * Below 15°C → Sweater / Jacket
  * 15°C – 25°C → Light clothes
  * Above 25°C → Sunglasses, Sunscreen, Cap

* Smart Packing Suggestions
  Weather conditions help users decide what to pack.

---

## Screens

* Splash Screen
* Home Screen
* Trip Detail Screen
* Packing Catalog
* Suitcase Packing View
* Weather Screen

---

## Tech Stack

* Flutter
* Dart
* OpenWeatherMap API
* HTTP package

---

## Getting Started

### Clone the repository

```bash
git clone https://github.com/ragul-rajendran18/packlite.git
```

### Navigate to the project

```bash
cd packlite
```

### Install dependencies

```bash
flutter pub get
```

### Run the app

```bash
flutter run
```

---

## Project Structure

```
lib/
 ├── screens/
 │   ├── home_screen.dart
 │   ├── trip_detail_screen.dart
 │   └── weather_screen.dart
 │
 ├── models/
 │   ├── trip_model.dart
 │   └── item_model.dart
 │
 ├── widgets/
 │   ├── trip_card.dart
 │   └── create_trip_sheet.dart
 │
 ├── data/
 │   └── dummy_items.dart
 │
 └── services/
     └── weather_service.dart
```

---

## Future Improvements

* Auto detect destination weather
* 5 day weather forecast
* Trip sharing with invite codes
* Cloud sync
* Smart packing assistant

---

## Author

Ragul

GitHub:
https://github.com/ragul-rajendran18
