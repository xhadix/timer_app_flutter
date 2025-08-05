# Flutter Timer Application

A Flutter timer application built with BLoC state management based on the provided Figma designs and requirements.

## Features

- **Timer List Screen**: Display list of timers with project details and ongoing timers
- **Create Timer Screen**: Form to create new timers with project and task selection
- **Task Details Screen**: Detailed view of tasks with timesheet functionality
- **State Management**: BLoC pattern for global state management
- **Responsive Design**: Mobile-first design with custom theme
- **Navigation**: GoRouter for seamless navigation between screens

## Technology Stack

- Flutter 3.x with Dart
- BLoC pattern for state management
- Material Design 3 for UI components
- Custom theme implementation
- In-memory data management

## Project Structure

```
lib/
├── blocs/
│   └── timer/
│       ├── timer_bloc.dart
│       ├── timer_event.dart
│       └── timer_state.dart
├── models/
│   ├── timer.dart
│   ├── project.dart
│   └── task.dart
├── screens/
│   ├── timer_list_screen.dart
│   ├── create_timer_screen.dart
│   └── task_details_screen.dart
├── widgets/
│   ├── common/
│   │   ├── custom_app_bar.dart
│   │   └── timer_card.dart
│   ├── timer_list/
│   └── create_timer/
├── utils/
│   ├── constants.dart
│   └── helpers.dart
└── main.dart
```

## Getting Started

### Prerequisites

- Flutter SDK (3.x or higher)
- Dart SDK
- Android Studio / VS Code
- Android Emulator or iOS Simulator

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd timer_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run
```

### Build for Production

```bash
flutter build apk
flutter build ios
```

## Development Approach

This project follows a step-by-step development approach:

1. **Project Setup** - Initialize Flutter project with dependencies ✅
2. **Theme Implementation** - Create custom theme matching Figma designs
3. **BLoC Architecture** - Implement state management with BLoC pattern ✅
4. **UI Components** - Build custom widgets following design system
5. **Navigation** - Implement proper navigation patterns
6. **Timer Logic** - Add timer functionality and state synchronization ✅

## UI/UX Features

- **Gradient Background**: From bottom #1d47ba to top #0e215a
- **AppBar Layout**: Page name on left, action buttons on right
- **Timer Cards**: Left content (title, project, timeline) and right section (ongoing timer)
- **Navigation**: Timer-focused navigation with proper routing
- **Responsive Design**: Mobile-first approach with custom theme

## State Management

The application uses BLoC pattern for state management with the following features:

- Timer CRUD operations
- Timer state management (running, paused, completed)
- Real-time timer updates
- Global state synchronization across screens

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.0
  hydrated_bloc: ^9.1.0
  go_router: ^12.0.0
  equatable: ^2.0.5

dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: ^9.1.0
```

## Current Status

### ✅ Completed (Step 1)
- [x] Flutter project setup with dependencies
- [x] BLoC architecture implementation
- [x] Data models (Timer, Project, Task)
- [x] Timer BLoC with events and states
- [x] Utility functions and constants
- [x] Basic app structure and navigation setup

### 🔄 In Progress
- [ ] Custom theme implementation
- [ ] Timer list screen
- [ ] Create timer screen
- [ ] Task details screen
- [ ] Navigation implementation

### 📋 Planned
- [ ] UI components and widgets
- [ ] Form validation
- [ ] Timer functionality
- [ ] State synchronization
- [ ] Testing implementation

## Design System

### Color Scheme
- **Primary Gradient**: #1d47ba to #0e215a
- **Navigation Background**: #1f49be with blur effect
- **Text Colors**: White with opacity variations
- **Borders**: White with transparency

### Component Styling
- **Consistent Spacing**: Using AppSpacing constants
- **Typography**: Proper font weights and sizes
- **Interactive States**: Hover and focus states
- **Responsive Design**: Mobile-first approach

## Testing

```bash
# Run unit tests
flutter test

# Run widget tests
flutter test test/widget_test.dart

# Run integration tests
flutter test integration_test/
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License.
