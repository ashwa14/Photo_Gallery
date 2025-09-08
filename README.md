# findoc_assig

A new Flutter project.

## Getting Started

A fully functional Photo Gallery application built with Flutter using BLoC for state management. This app fetches images from Picsum API
 and provides features like responsive grid view, image details, favorites, pull-to-refresh, shimmer loading effect, and hero animations.

Project Structure: 

 - lib/
  - assets/
    - piscum_image.dart
  - Bloc/
    - Home/
      - home_bloc.dart
      - home_event.dart
      - home_state.dart
    Login/
      - login_bloc.dart
      - login_event.dart
      - login_state.dart
    Navigation/
      - home.dart
      - login.dart
    widgets/
      - image.dart
  - store/
    - auth.dart
    - piscum.dart
  - main.dart


- Bloc → Contains all state management logic

- Navigation → Screens & UI

- Widgets → Reusable components

- Store → Local data handling and APIs

Dependencies

flutter_bloc – State management

google_fonts – Custom fonts

http – API requests

shimmer – Loading effect


