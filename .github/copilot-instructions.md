# AI Agent Instructions for Biliran Booking App

This document provides essential context for AI agents working with this Flutter application.

## Project Overview

This is a Flutter application targeting multiple platforms (Android, iOS, web, desktop) designed for booking services in Biliran. The project follows standard Flutter architecture and conventions.

## Development Environment

- Flutter SDK version: ^3.9.2
- Dart SDK version: ^3.9.2
- Key dependencies:
  - cupertino_icons: ^1.0.8
  - flutter_lints: ^5.0.0 (dev)

## Project Structure

```
lib/               # Main application code
test/             # Test files
android/          # Android-specific configuration
ios/              # iOS-specific configuration
web/              # Web platform files
linux/            # Linux platform configuration
macos/            # macOS platform configuration
windows/          # Windows platform configuration
```

## Development Workflow

1. **Setup**:
   ```bash
   flutter pub get     # Install dependencies
   flutter analyze    # Run static analysis
   flutter test      # Run tests
   ```

2. **Running the App**:
   ```bash
   flutter run       # Run on connected device/simulator
   ```

## Code Style & Conventions

1. The project uses the standard Flutter lint rules from `package:flutter_lints/flutter.yaml`
2. No custom lint rules have been defined yet in `analysis_options.yaml`
3. Follow the standard Flutter/Dart file naming convention: lowercase with underscores

## Platform-Specific Notes

The app is configured for multiple platforms. When making changes:
- Ensure Android Gradle files (`android/build.gradle.kts`, `android/app/build.gradle.kts`) remain properly configured
- iOS changes should be made in the `ios/Runner` directory
- Platform-specific code should be organized in respective platform directories

## Common Tasks

1. **Adding Dependencies**:
   - Add to `pubspec.yaml`
   - Run `flutter pub get`
   - Check for platform-specific setup requirements

2. **Running Tests**:
   - Widget tests go in `test/widget_test.dart`
   - Run with `flutter test`

## Areas for AI Focus

When assisting with this project:
1. Maintain cross-platform compatibility
2. Follow Flutter best practices for state management and widget structure
3. Ensure proper null safety usage (project uses modern Dart with sound null safety)
4. Consider platform-specific implications when adding features

## Note to AI Agents

This is a new project in early development stages. When making changes:
1. Start with foundational Flutter patterns
2. Document any architectural decisions
3. Set up clear widget hierarchies
4. Consider implementing core booking-related features first