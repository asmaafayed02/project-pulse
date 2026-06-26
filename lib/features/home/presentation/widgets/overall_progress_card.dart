import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:project_pulse/core/constants/app_colors.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';

class OverallProgressCard extends StatelessWidget {
  final int completedTasks;
  final int inProgressTasks;
  final int pendingTasks;

  const OverallProgressCard({
    super.key,
    required this.completedTasks,
    required this.inProgressTasks,
    required this.pendingTasks,
  });

  int get _total => completedTasks + inProgressTasks + pendingTasks;

  double get _completionRate =>
      _total == 0 ? 0.0 : completedTasks / _total;

  @override
  Widget build(BuildContext context) {
    final percent = (_completionRate * 100).round();

    return Container(
      padding: EdgeInsets.all(AppSizes.s16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSizes.r16),
        border: Border.all(
          color: context.colors.outlineVariant,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Title row ──────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Overall Progress',
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: context.colors.onSurface.withValues(alpha: 0.35),
                size: 20,
              ),
            ],
          ),

          SizedBox(height: AppSizes.s16),

          // ── Chart + Legend ──────────────────────
          Row(
            children: [
              // Circular progress
              SizedBox(
                width: 96,
                height: 96,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(96, 96),
                      painter: _DonutPainter(
                        completed: completedTasks,
                        inProgress: inProgressTasks,
                        pending: pendingTasks,
                        total: _total,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$percent%',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          'done',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colors.onSurface.withValues(alpha: 0.45),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(width: AppSizes.s20),

              // Legend
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _LegendItem(
                      color: AppColors.success,
                      label: 'Completed',
                      count: completedTasks,
                    ),
                    SizedBox(height: AppSizes.s10),
                    _LegendItem(
                      color: AppColors.warning,
                      label: 'In Progress',
                      count: inProgressTasks,
                    ),
                    SizedBox(height: AppSizes.s10),
                    _LegendItem(
                      color: context.colors.onSurface.withValues(alpha: 0.2),
                      label: 'Pending',
                      count: pendingTasks,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Legend Item ───────────────────────────────────────

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final int count;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: AppSizes.s8),
        Expanded(
          child: Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colors.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ),
        Text(
          count.toString(),
          style: context.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: context.colors.onSurface,
          ),
        ),
      ],
    );
  }
}

// ── Donut Painter ─────────────────────────────────────

class _DonutPainter extends CustomPainter {
  final int completed;
  final int inProgress;
  final int pending;
  final int total;

  const _DonutPainter({
    required this.completed,
    required this.inProgress,
    required this.pending,
    required this.total,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (total == 0) return;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = (size.width / 2) - 8;
    const strokeWidth = 12.0;
    const gapDeg = 2.0;
    const gapRad = gapDeg * math.pi / 180;
    const startAngle = -math.pi / 2;

    final segments = [
      (completed,   AppColors.success),
      (inProgress,  AppColors.warning),
      (pending,     AppColors.grey100),
    ];

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Background track
    canvas.drawCircle(
      Offset(cx, cy),
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..color = const Color(0xFFF0F0F0),
    );

    double currentAngle = startAngle;
    final totalGap = gapRad * segments.length;
    final usableArc = 2 * math.pi - totalGap;

    for (final (count, color) in segments) {
      final sweep = (count / total) * usableArc;
      if (sweep <= 0) {
        currentAngle += gapRad;
        continue;
      }
      paint.color = color;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: radius),
        currentAngle,
        sweep,
        false,
        paint,
      );
      currentAngle += sweep + gapRad;
    }
  }

  @override
  bool shouldRepaint(_DonutPainter oldDelegate) =>
      oldDelegate.completed != completed ||
      oldDelegate.inProgress != inProgress ||
      oldDelegate.pending != pending;
}