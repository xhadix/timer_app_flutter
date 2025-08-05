import 'package:flutter/material.dart';
import '../../utils/constants.dart';

enum SortOption { recent, oldest}

class SortModal extends StatelessWidget {
  final bool isOpen;
  final SortOption currentSort;
  final Function(SortOption) onSortSelect;
  final VoidCallback onClose;

  const SortModal({
    super.key,
    required this.isOpen,
    required this.currentSort,
    required this.onSortSelect,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    if (!isOpen) return const SizedBox.shrink();

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navigationBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: AppSpacing.md),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textSecondary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sort by',
                  style: AppTypography.heading2,
                ),
                IconButton(
                  onPressed: onClose,
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
          // Sort options
          ...SortOption.values.map((option) => _buildSortOption(option)),
          
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildSortOption(SortOption option) {
    final isSelected = currentSort == option;
    final label = _getSortLabel(option);
    final icon = _getSortIcon(option);

    return InkWell(
      onTap: () {
        onSortSelect(option);
        onClose();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
              size: 20,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                label,
                style: AppTypography.body1.copyWith(
                  color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check,
                color: AppColors.textPrimary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  String _getSortLabel(SortOption option) {
    switch (option) {
      case SortOption.recent:
        return 'Recent';
      case SortOption.oldest:
        return 'Oldest';
    }
  }

  IconData _getSortIcon(SortOption option) {
    switch (option) {
      case SortOption.recent:
        return Icons.access_time;
      case SortOption.oldest:
        return Icons.history;
    }
  }
} 