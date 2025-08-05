import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/timer/timer_bloc.dart';
import 'utils/constants.dart';
import 'utils/theme.dart';
import 'widgets/common/custom_app_bar.dart';
import 'widgets/common/custom_button.dart';
import 'widgets/common/custom_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(),
      child: MaterialApp(
        title: 'Timer App',
        theme: AppTheme.lightTheme,
        home: const Scaffold(
          appBar: CustomAppBar(
            title: 'Timer App',
            actions: [
              IconButton(
                icon: Icon(Icons.sort),
                onPressed: null,
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: null,
              ),
            ],
          ),
          body: Container(
            decoration: AppTheme.gradientDecoration,
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  CustomCard(
                    child: Column(
                      children: [
                        Icon(
                          Icons.timer,
                          size: 64,
                          color: AppColors.textPrimary,
                        ),
                        SizedBox(height: AppSpacing.lg),
                        Text(
                          'Timer App Setup Complete!',
                          style: AppTypography.heading1,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: AppSpacing.md),
                        Text(
                          'Theme implementation ready',
                          style: AppTypography.body2,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSpacing.lg),
                  CustomButton(
                    text: 'Create Timer',
                    icon: Icons.add,
                    onPressed: null,
                  ),
                  SizedBox(height: AppSpacing.md),
                  CustomButton(
                    text: 'View Timers',
                    isOutlined: true,
                    onPressed: null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
