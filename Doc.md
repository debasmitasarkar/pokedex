# pokedex

A new Flutter project.

## Getting Started

Instructions to run:

1. This project uses flutter version 3.0.3, Make sure you have that version installed or do `flutter upgrade`
2. First do `flutter pub get` and then `flutter run`
3. Since this project uses `build_runner` to generate mock files for test cases, you have to run `flutter pub run build_runner build --delete-conflicting-outputs` this first to run test cases
4. To run test cases use `flutter test`

Packages used:

- State Management - flutter_riverpod: ^2.0.0-dev.9
- To compare object - equatable: ^2.0.3
- network - http: ^0.13.4
- loader with shimmer effect - shimmer: ^2.0.0
- for infinite scroll in all pokemons - infinite_scroll_pagination: ^3.2.0
- To store values in local storage - shared_preferences: ^2.0.15
