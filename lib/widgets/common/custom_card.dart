import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../utils/theme.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final bool isClickable;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.isClickable = false,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final cardDecoration = BoxDecoration(
      color: backgroundColor ?? AppColors.cardBackground,
      borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.md),
      border: Border.all(
        color: AppColors.borderColor,
        width: 1,
      ),
    );

    Widget cardContent = Container(
      decoration: cardDecoration,
      padding: padding ?? const EdgeInsets.all(AppSpacing.md),
      margin: margin,
      child: child,
    );

    if (isClickable || onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.md),
        child: cardContent,
      );
    }

    return cardContent;
  }
}

class GradientCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final bool isClickable;

  const GradientCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.isClickable = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget cardContent = Container(
      decoration: AppTheme.gradientDecoration,
      padding: padding ?? const EdgeInsets.all(AppSpacing.md),
      margin: margin,
      child: child,
    );

    if (isClickable || onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: cardContent,
      );
    }

    return cardContent;
  }
} 