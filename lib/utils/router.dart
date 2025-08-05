import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/timer_list_screen.dart';
import '../screens/create_timer_screen.dart';
import '../screens/task_details_screen.dart';

class AppRouter {
  static const String timerList = '/';
  static const String createTimer = '/create';
  static const String taskDetails = '/task/:id';

  static final GoRouter router = GoRouter(
    initialLocation: timerList,
    routes: [
      GoRoute(
        path: timerList,
        name: 'timerList',
        builder: (context, state) => const TimerListScreen(),
      ),
      GoRoute(
        path: createTimer,
        name: 'createTimer',
        builder: (context, state) => const CreateTimerScreen(),
      ),
      GoRoute(
        path: taskDetails,
        name: 'taskDetails',
        builder: (context, state) {
          final timerId = state.pathParameters['id']!;
          return TaskDetailsScreen(timerId: timerId);
        },
      ),
    ],
    errorBuilder: (context, state) => const ErrorScreen(),
  );
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('Page not found'),
      ),
    );
  }
} 