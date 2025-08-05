import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/timer/timer_bloc.dart';
import '../blocs/timer/timer_state.dart';
import '../widgets/common/custom_app_bar.dart';
import '../widgets/common/sort_modal.dart';
import '../widgets/timer_list/timer_card.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';
import '../utils/helpers.dart';

class TimerListScreen extends StatefulWidget {
  const TimerListScreen({super.key});

  @override
  State<TimerListScreen> createState() => _TimerListScreenState();
}

class _TimerListScreenState extends State<TimerListScreen> {
  bool _showSortModal = false;
  SortOption _currentSort = SortOption.recent;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Timesheets',
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              setState(() {
                _showSortModal = true;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.go('/create');
            },
          ),
        ],
      ),
      body: Container(
        decoration: AppTheme.gradientDecoration,
        child: BlocBuilder<TimerBloc, TimerState>(
          builder: (context, state) {
            if (state is TimerLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.textPrimary),
                ),
              );
            }

            if (state is TimerError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'Error: ${state.message}',
                      style: AppTypography.body1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            if (state is TimerLoaded) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'You have ${state.timers.length} Timers',
                          style: AppTypography.body1.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Expanded(
                          child: state.timers.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.timer_outlined,
                                        size: 64,
                                        color: AppColors.textSecondary,
                                      ),
                                      const SizedBox(height: AppSpacing.lg),
                                      Text(
                                        'No timers yet',
                                        style: AppTypography.heading2,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: AppSpacing.md),
                                      Text(
                                        'Create your first timer to get started',
                                        style: AppTypography.body2,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: _getSortedTimers(state.timers).length,
                                  itemBuilder: (context, index) {
                                    final timer = _getSortedTimers(state.timers)[index];
                                    return TimerCard(timer: timer);
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                  // Sort Modal
                  if (_showSortModal)
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showSortModal = false;
                          });
                        },
                        child: Container(
                          color: Colors.black54,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: SortModal(
                              isOpen: _showSortModal,
                              currentSort: _currentSort,
                              onSortSelect: _handleSortSelect,
                              onClose: () {
                                setState(() {
                                  _showSortModal = false;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }

            return const Center(
              child: Text(
                'Welcome to Timer App',
                style: AppTypography.heading1,
              ),
            );
          },
        ),
      ),
    );
  }

  List<dynamic> _getSortedTimers(List<dynamic> timers) {
    final sortedTimers = List.from(timers);
    
    switch (_currentSort) {
      case SortOption.recent:
        sortedTimers.sort((a, b) => b.id.compareTo(a.id));
        break;
      case SortOption.oldest:
        sortedTimers.sort((a, b) => a.id.compareTo(b.id));
        break;
    }
    
    return sortedTimers;
  }

  void _handleSortSelect(SortOption option) {
    setState(() {
      _currentSort = option;
      _showSortModal = false;
    });
  }
}

 