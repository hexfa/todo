# Flutter Todoist App

## Details 📜
This is a Flutter app designed to interact with the Todoist API, offering a seamless task management experience. It incorporates modern Flutter technologies, adheres to Clean Architecture principles, and is built for scalability and maintainability. 

---

## Table of Contents
1. [Features](#features-🏹)
2. [Technologies Used](#technologies-used)
3. [Prerequisites](#prerequisites)
4. [Setup](#setup-🕺)
5. [Preview](#preview-📱)
6. [Resources](#resources-ℹ️)
7. [Contributing](#contributing)

---

## Features 🏹
The Flutter Todoist App offers a variety of features aimed at enhancing productivity:

- **Task Management**: View, add, and manage tasks fetched from the [Todoist API](https://developer.todoist.com/rest/v2/#overview).
- **Dark and Light Themes**: Switch between themes for comfortable viewing.
- **Localization**: Supports English and German languages, ensuring accessibility for a broader audience.
- **Task Timer**: Each task includes a built-in timer to help users track time spent.
- **Completed Tasks View**: Review tasks marked as complete.
- **Offline Mode**: Retain access to previously fetched tasks using local storage.
- **Responsive Design**: Adapts beautifully to various screen sizes.
- **Clean Architecture**: Ensures maintainable, testable, and scalable code structure.
- **Unit Testing**: Comprehensive tests to ensure functionality and reliability.

---

## Technologies Used
The app is built with the following technologies:

### Core Libraries:
- **Flutter**: Framework for crafting high-quality, natively compiled applications.
- **Dart**: Programming language optimized for fast development and expressive UI.

### State Management and Dependencies:
- **Flutter Bloc**: Efficient state management solution.
- **GetIt**: Dependency injection and service locator.

### Networking and APIs:
- **Dio**: HTTP client for managing API calls.
- **Retrofit**: Simplifies API requests with type-safe REST client generation.

### Local Storage and Utilities:
- **Hive**: Lightweight, blazing fast, key-value database.
- **Flutter Secure Storage**: For securely storing sensitive user data.
- **Shared Preferences**: Persistent storage for basic key-value data.

### UI and Theming:
- **Lottie**: Dynamic animations.
- **Google Fonts**: Enhances UI with custom typography.
- **Go Router**: Advanced routing for Flutter apps.

### Additional Tools:
- **Intl**: For internationalization and localization.
- **Animated Theme Switcher**: Enables smooth transitions between themes.
- **Connectivity Plus**: Monitors internet connectivity.

---

## Prerequisites
Before running the app, make sure you have the following installed:

- **Flutter SDK**: Version 3.0 or later.
- **Dart**: Version 2.18 or later.
- **Android Studio/Visual Studio Code**: With the Flutter and Dart plugins.
- **API Access**: Ensure you have API credentials for Todoist.

---

## Setup 🕺

1. Clone this repository:
   ```bash
   git clone <repository-url>
   ```

2. Navigate to the project directory:
   ```bash
   cd flutter_todoist_app
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

For advanced configuration and customization, refer to the `lib/config` folder for environment-specific settings.

---

## Preview 📱
Below are examples of the app's user interface and features:

### Screenshots

<img src="https://github.com/hexfa/Files/blob/main/photo_1_2024-12-22_16-31-36.jpg" height="649" width="300" alt="Rick and morty App hexfa">
<img src="https://github.com/hexfa/Files/blob/main/photo_2_2024-12-22_16-31-36.jpg" height="649" width="300" alt="Rick and morty App hexfa">
<img src="https://github.com/hexfa/Files/blob/main/photo_3_2024-12-22_16-31-36.jpg" height="649" width="300" alt="Rick and morty App hexfa">
<img src="https://github.com/hexfa/Files/blob/main/photo_4_2024-12-22_16-31-36.jpg" height="649" width="300" alt="Rick and morty App hexfa">
<img src="https://github.com/hexfa/Files/blob/main/photo_5_2024-12-22_16-31-36.jpg" height="649" width="300" alt="Rick and morty App hexfa">
<img src="https://github.com/hexfa/Files/blob/main/photo_6_2024-12-22_16-31-36.jpg" height="649" width="300" alt="Rick and morty App hexfa">
<img src="https://github.com/hexfa/Files/blob/main/photo_7_2024-12-22_16-31-36.jpg" height="649" width="300" alt="Rick and morty App hexfa">
<img src="https://github.com/hexfa/Files/blob/main/photo_8_2024-12-22_16-31-36.jpg" height="649" width="300" alt="Rick and morty App hexfa">
<img src="https://github.com/hexfa/Files/blob/main/photo_9_2024-12-22_16-31-36.jpg" height="649" width="300" alt="Rick and morty App hexfa">
<img src="https://github.com/hexfa/Files/blob/main/photo_10_2024-12-22_16-31-36.jpg" height="649" width="300" alt="Rick and morty App hexfa">
<img src="https://github.com/hexfa/Files/blob/main/photo_11_2024-12-22_16-31-36.jpg" height="649" width="300" alt="Rick and morty App hexfa">
<img src="https://github.com/hexfa/Files/blob/main/photo_12_2024-12-22_16-31-36.jpg" height="649" width="300" alt="Rick and morty App hexfa">


### Video Demo
Experience the app in action:
[Watch Demo](https://via.placeholder.com/demo-video)

---

## Resources ℹ️

- **Todoist API Documentation**: [Todoist API](https://developer.todoist.com/rest/v2/#overview).
- **Localization**: [Flutter Intl Package](https://pub.dev/packages/intl).
- **State Management**: [Flutter Bloc Documentation](https://bloclibrary.dev/#/).
- **Clean Architecture**: Based on [Uncle Bob’s Clean Architecture](https://blog.cleancoder.com/).

---

## Contributing
We welcome contributions from the community. To contribute:

1. Fork the repository.
2. Create a feature or bug fix branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes with clear descriptions:
   ```bash
   git commit -m "Add feature description"
   ```
4. Push your branch to your fork:
   ```bash
   git push origin feature-name
   ```
5. Submit a pull request with detailed information about your changes.

---

Thank you for contributing! 🚀

