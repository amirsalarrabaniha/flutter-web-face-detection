# Flutter Web Face Detection with Google MediaPipe

## Overview

This project is a Flutter web application that detects faces using **Google MediaPipe Face Detection
**. The app processes live webcam footage and identifies facial features in real-time, making it
suitable for applications like facial recognition, augmented reality, and interactive experiences.

## Features

- Real-time face detection using Google MediaPipe
- Runs on **Flutter Web**
- Efficient and lightweight detection
- Works directly with a webcam
- Optimized for performance

## Technologies Used

- **Flutter Web** (Dart)
- **Google MediaPipe Face Detection**
- **WebRTC** for camera access
- **Canvas API** for overlay rendering (if needed)

## Installation

1. Clone the repository:
   ```sh
   git clone git@github.com:amirsalarrabaniha/flutter-web-face-detection.git
   ```
2. Navigate to the project folder:
   ```sh
   cd f
   ```
3. &#x20;git\@github.com\:amirsalarrabaniha/flutter-web-face-detection.gitInstall dependencies:
   ```sh
   flutter pub get
   ```
4. Run the application:
   ```sh
   flutter run -d chrome
   ```

## Usage

- **Start Detection:** Open the web app and allow camera permissions.
- **View Results:** The app will detect and highlight faces in real-time.

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.8
  camera: ^0.11.0+2
  js: ^0.6.5
  google_mediapipe_face_detection: ^0.0.2
  google_mlkit_commons: any
```

## License

This project is licensed under the MIT License.

---

Feel free to modify the README to match your specific project details!

