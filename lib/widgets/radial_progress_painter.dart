import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class RadialProgressWidget extends StatefulWidget {
  final double calorieProgress; // 0.0 to 1.0
  final double hydrationProgress; // 0.0 to 1.0
  final int currentCalories;
  final int targetCalories;
  final String comparisonText;

  const RadialProgressWidget({
    super.key,
    required this.calorieProgress,
    required this.hydrationProgress,
    required this.currentCalories,
    required this.targetCalories,
    this.comparisonText = '+18% vs yesterday',
  });

  @override
  State<RadialProgressWidget> createState() => _RadialProgressWidgetState();
}

class _RadialProgressWidgetState extends State<RadialProgressWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(RadialProgressWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.calorieProgress != widget.calorieProgress) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final currentCal = (widget.currentCalories * _animation.value).toInt();
        return SizedBox(
          width: 220,
          height: 220,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(210, 210),
                painter: _RadialTelemetryPainter(
                  calorieProgress: widget.calorieProgress * _animation.value,
                  hydrationProgress: widget.hydrationProgress * _animation.value,
                ),
              ),
              // Center overlay text
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$currentCal',
                    style: AppTypography.metricLg(color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'of ${widget.targetCalories} kcal',
                    style: AppTypography.labelSm(color: AppColors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.trending_up_rounded,
                        color: AppColors.primaryLime,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.comparisonText,
                        style: AppTypography.labelSm(color: AppColors.primaryLime),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RadialTelemetryPainter extends CustomPainter {
  final double calorieProgress;
  final double hydrationProgress;

  _RadialTelemetryPainter({
    required this.calorieProgress,
    required this.hydrationProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2 - 12;
    final innerRadius = outerRadius - 20;

    // Track Backgrounds
    final outerTrackPaint = Paint()
      ..color = AppColors.surfaceContainerHigh
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final innerTrackPaint = Paint()
      ..color = AppColors.surfaceContainer
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, outerRadius, outerTrackPaint);
    canvas.drawCircle(center, innerRadius, innerTrackPaint);

    const startAngle = -pi / 2;

    // Inner Hydration/Pace Cyan Ring
    final innerSweep = 2 * pi * hydrationProgress.clamp(0.0, 1.0);
    if (innerSweep > 0) {
      final innerProgressPaint = Paint()
        ..color = AppColors.secondaryCyan.withOpacity(0.85)
        ..strokeWidth = 6
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: innerRadius),
        startAngle,
        innerSweep,
        false,
        innerProgressPaint,
      );
    }

    // Outer Primary Calorie Ring Glow
    final outerSweep = 2 * pi * calorieProgress.clamp(0.0, 1.0);
    if (outerSweep > 0) {
      // Subtle Glow layer
      final glowPaint = Paint()
        ..color = AppColors.primaryLime.withOpacity(0.4)
        ..strokeWidth = 16
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: outerRadius),
        startAngle,
        outerSweep,
        false,
        glowPaint,
      );

      // Solid Primary Stroke
      final outerProgressPaint = Paint()
        ..color = AppColors.primaryLime
        ..strokeWidth = 12
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: outerRadius),
        startAngle,
        outerSweep,
        false,
        outerProgressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RadialTelemetryPainter oldDelegate) {
    return oldDelegate.calorieProgress != calorieProgress ||
        oldDelegate.hydrationProgress != hydrationProgress;
  }
}
