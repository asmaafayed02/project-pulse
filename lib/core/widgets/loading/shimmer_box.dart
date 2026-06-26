import 'package:flutter/material.dart';
import 'package:project_pulse/core/extensions/context_extension.dart';

/// A single animated shimmer "bone" — a rounded box that pulses
/// to indicate loading content of that shape.
class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadiusGeometry borderRadius;

  const ShimmerBox({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  Widget build(BuildContext context) {
    return _Shimmer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: context.colors.onSurface.withValues(alpha: 0.08),
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}

/// Wrap any widget (or group of [ShimmerBox]es) to apply a single
/// shared shimmer animation, so multiple skeleton bones pulse in sync.
class _Shimmer extends StatefulWidget {
  final Widget child;
  const _Shimmer({required this.child});

  @override
  State<_Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<_Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final t = _controller.value;
            return LinearGradient(
              colors: [
                Colors.transparent,
                Colors.white.withValues(alpha: 0.35),
                Colors.transparent,
              ],
              stops: const [0.35, 0.5, 0.65],
              begin: Alignment(-1 + 3 * t, 0),
              end: Alignment(1 + 3 * t, 0),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}