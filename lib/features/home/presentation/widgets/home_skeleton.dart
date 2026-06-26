import 'package:flutter/material.dart';
import 'package:project_pulse/core/constants/app_sizes.dart';
import 'package:project_pulse/core/widgets/loading/shimmer_box.dart';

/// Skeleton placeholder that mirrors HomePage's data layout 1:1,
/// so the transition from loading → data feels seamless (no layout jump).
class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(AppSizes.s16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Greeting ──────────────────────────
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(width: 120, height: 14),
                    SizedBox(height: AppSizes.s8),
                    ShimmerBox(width: 160, height: 22),
                  ],
                ),
              ),
              ShimmerBox(
                width: 44,
                height: 44,
                borderRadius: BorderRadius.circular(22),
              ),
            ],
          ),

          SizedBox(height: AppSizes.s20),

          // ── Stats row ─────────────────────────
          Row(
            children: [
              Expanded(child: ShimmerBox(height: 72, borderRadius: BorderRadius.circular(AppSizes.r16))),
              SizedBox(width: AppSizes.s12),
              Expanded(child: ShimmerBox(height: 72, borderRadius: BorderRadius.circular(AppSizes.r16))),
            ],
          ),

          SizedBox(height: AppSizes.s16),

          // ── Overall progress card ─────────────
          ShimmerBox(height: 160, borderRadius: BorderRadius.circular(AppSizes.r16)),

          SizedBox(height: AppSizes.s20),

          // ── Recent projects ───────────────────
          ShimmerBox(width: 130, height: 16),
          SizedBox(height: AppSizes.s12),
          ShimmerBox(height: 64, borderRadius: BorderRadius.circular(AppSizes.r14)),
          SizedBox(height: AppSizes.s10),
          ShimmerBox(height: 64, borderRadius: BorderRadius.circular(AppSizes.r14)),
        ],
      ),
    );
  }
}