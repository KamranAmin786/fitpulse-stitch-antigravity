import 'package:flutter/material.dart';
import '../models/sample_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bar.dart';
import '../widgets/ecg_pulse_painter.dart';
import '../widgets/radial_progress_painter.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onStartWorkout;
  final VoidCallback onNavigateToProfile;

  const HomeScreen({
    super.key,
    required this.onStartWorkout,
    required this.onNavigateToProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FitPulseAppBar(
        subtitle: 'Home',
        onProfileTap: onNavigateToProfile,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting & Streak Top Banner
            _buildGreetingAndStreak(),
            const SizedBox(height: 16),

            // Weekly Streak Micro-Calendar Tracker
            _buildWeeklyRhythm(),
            const SizedBox(height: 16),

            // Radial Calorie Telemetry Hub
            _buildRadialTelemetryCard(),
            const SizedBox(height: 16),

            // Real-time Pulse Graphic Banner
            _buildRecoveryPulseBanner(),
            const SizedBox(height: 20),

            // Today's Routine Section
            _buildTodaysRoutineHeader(),
            const SizedBox(height: 12),

            // Primary Workout Card
            _buildPrimaryWorkoutCard(context),
            const SizedBox(height: 12),

            // Secondary Routine Card (Cooldown)
            _buildCooldownCard(),
            const SizedBox(height: 16),

            // Pulse Coach Tip Card
            _buildCoachTipCard(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildGreetingAndStreak() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'MON, OCT 24',
                    style: AppTypography.labelSm(color: AppColors.primaryLime).copyWith(
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryLimeDim,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Optimal Readiness',
                    style: AppTypography.labelSm(color: AppColors.onSurfaceVariant),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Good morning, Alex',
                style: AppTypography.headlineLg(),
              ),
            ],
          ),
        ),
        // Streak Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(999),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🔥', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
              Text(
                '5 Day Streak',
                style: AppTypography.labelMd(color: AppColors.primaryLime).copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyRhythm() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'WEEKLY RHYTHM',
                style: AppTypography.labelSm(color: AppColors.onSurfaceVariant).copyWith(
                  letterSpacing: 0.8,
                ),
              ),
              Text(
                '5 of 7 targets met',
                style: AppTypography.labelSm(color: AppColors.primaryLime).copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: SampleData.weeklyRhythm.map((dayItem) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2.5),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: dayItem.isToday
                        ? AppColors.surfaceContainerHighest
                        : AppColors.surfaceLow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        dayItem.day,
                        style: AppTypography.labelSm(
                          color: dayItem.isToday
                              ? AppColors.primaryLime
                              : AppColors.onSurfaceVariant,
                        ).copyWith(
                          fontWeight: dayItem.isToday ? FontWeight.w800 : FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      if (dayItem.isCompleted)
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLime,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryLime.withOpacity(0.35),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            size: 16,
                            color: AppColors.onPrimary,
                          ),
                        )
                      else if (dayItem.isToday)
                        Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            color: AppColors.surfaceLowest,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: AppColors.primaryLime,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryLime.withOpacity(0.8),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      else
                        Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            color: AppColors.surfaceContainerHigh,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.bedtime_outlined,
                            size: 14,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRadialTelemetryCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outline),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.local_fire_department_rounded,
                    color: AppColors.primaryLime,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'DAILY OUTPUT',
                    style: AppTypography.labelMd(color: AppColors.textPrimary).copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '75% GOAL',
                  style: AppTypography.labelSm(color: AppColors.primaryLime).copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Radial Telemetry Dual Rings with Animated Center
          const Center(
            child: RadialProgressWidget(
              calorieProgress: SampleData.calorieProgress,
              hydrationProgress: SampleData.hydrationProgress,
              currentCalories: SampleData.currentCalories,
              targetCalories: SampleData.targetCalories,
            ),
          ),
          const SizedBox(height: 8),

          // Micro Telemetry Stat Badges (Active, Heart, Steps)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLow,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                _buildMicroStat(
                  icon: Icons.timer_outlined,
                  iconColor: AppColors.secondaryCyan,
                  label: 'ACTIVE',
                  value: '48',
                  unit: 'm',
                ),
                Container(
                  width: 1,
                  height: 32,
                  color: AppColors.outline,
                ),
                _buildMicroStat(
                  icon: Icons.favorite_rounded,
                  iconColor: AppColors.error,
                  label: 'HEART',
                  value: '138',
                  unit: 'bpm',
                ),
                Container(
                  width: 1,
                  height: 32,
                  color: AppColors.outline,
                ),
                _buildMicroStat(
                  icon: Icons.directions_walk_rounded,
                  iconColor: AppColors.tertiaryEmerald,
                  label: 'STEPS',
                  value: '8,420',
                  unit: '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMicroStat({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required String unit,
  }) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 14, color: iconColor),
              const SizedBox(width: 4),
              Text(
                label,
                style: AppTypography.labelSm(color: AppColors.onSurfaceVariant),
              ),
            ],
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              text: value,
              style: AppTypography.headlineSm(color: AppColors.textPrimary).copyWith(
                fontWeight: FontWeight.w700,
              ),
              children: [
                if (unit.isNotEmpty)
                  TextSpan(
                    text: unit,
                    style: AppTypography.labelSm(color: AppColors.onSurfaceVariant).copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecoveryPulseBanner() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.outline),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background ECG Waveform
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            width: 160,
            child: CustomPaint(
              painter: EcgPulsePainter(color: AppColors.primaryLime),
            ),
          ),
          // Foreground Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLime.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.monitor_heart_rounded,
                    color: AppColors.primaryLime,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recovery Score: 92%',
                        style: AppTypography.headlineSm(color: AppColors.textPrimary).copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Cardio output primed for high strain',
                        style: AppTypography.bodySm(color: AppColors.onSurfaceVariant),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaysRoutineHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today's Routine",
              style: AppTypography.headlineMd(),
            ),
            Text(
              'Targeted progressive overload day',
              style: AppTypography.bodySm(color: AppColors.onSurfaceVariant),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHighest.withOpacity(0.6),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'See All',
                style: AppTypography.labelMd(color: AppColors.primaryLime),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 14,
                color: AppColors.primaryLime,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryWorkoutCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outline),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Image Banner with Overlays
          Stack(
            children: [
              SizedBox(
                height: 175,
                width: double.infinity,
                child: Image.network(
                  SampleData.workoutImageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.surfaceContainerHigh,
                    child: const Center(
                      child: Icon(
                        Icons.fitness_center_rounded,
                        color: AppColors.primaryLime,
                        size: 48,
                      ),
                    ),
                  ),
                ),
              ),
              // Gradient Shade
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.surfaceContainer,
                        AppColors.surfaceContainer.withOpacity(0.4),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // Top Badges
              Positioned(
                top: 12,
                left: 12,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.errorContainer,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.error,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'HIGH INTENSITY',
                            style: AppTypography.labelSm(color: AppColors.onErrorContainer).copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLowest.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'Upper Phase A',
                        style: AppTypography.labelSm(color: AppColors.onSurface).copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Bookmark Button
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLowest.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.bookmark_border_rounded,
                    color: AppColors.onSurface,
                    size: 20,
                  ),
                ),
              ),
              // Metric Badges on Bottom of Image
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Row(
                  children: [
                    _buildImagePill(Icons.schedule_rounded, '45 min', AppColors.primaryLime),
                    const SizedBox(width: 8),
                    _buildImagePill(Icons.local_fire_department_rounded, '420 kcal', AppColors.primaryLime),
                    const SizedBox(width: 8),
                    _buildImagePill(Icons.fitness_center_rounded, '6 exercises', AppColors.secondaryCyan),
                  ],
                ),
              ),
            ],
          ),

          // Details & Action
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hypertrophy Upper Body',
                  style: AppTypography.headlineSm().copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  'Heavy compound focus targeting pectoral fiber recruitment & anterior chain stability.',
                  style: AppTypography.bodySm(color: AppColors.onSurfaceVariant),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),

                // Targeted Muscle Chips
                Wrap(
                  spacing: 6,
                  children: [
                    _buildMuscleChip('Chest'),
                    _buildMuscleChip('Shoulders'),
                    _buildMuscleChip('Triceps'),
                    _buildMuscleChip('+3 more', isLime: true),
                  ],
                ),
                const SizedBox(height: 16),

                // Start Workout Now CTA Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: onStartWorkout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryLime,
                      foregroundColor: AppColors.onPrimary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      shadowColor: AppColors.primaryLime.withOpacity(0.4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.play_arrow_rounded,
                          color: AppColors.onPrimary,
                          size: 22,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Start Workout Now',
                          style: AppTypography.labelLg(color: AppColors.onPrimary).copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePill(IconData icon, String text, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceLowest.withOpacity(0.85),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: iconColor),
          const SizedBox(width: 4),
          Text(
            text,
            style: AppTypography.labelSm(color: AppColors.onSurface).copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMuscleChip(String label, {bool isLime = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: AppTypography.labelSm(
          color: isLime ? AppColors.primaryLime : AppColors.onSurface,
        ).copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildCooldownCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.outline),
      ),
      child: Row(
        children: [
          // Thumbnail
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(14),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              SampleData.cooldownImageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.self_improvement_rounded,
                color: AppColors.tertiaryEmerald,
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.tertiaryContainer,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'LOW INTENSITY',
                        style: AppTypography.labelSm(color: AppColors.tertiaryEmerald).copyWith(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '• 15 min',
                      style: AppTypography.bodySm(color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Core & Mobility Cool-down',
                  style: AppTypography.headlineSm().copyWith(fontWeight: FontWeight.w700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '95 kcal • 4 routines',
                  style: AppTypography.bodySm(color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
          ),
          // Play Button
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              color: AppColors.textPrimary,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoachTipCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.outline),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.secondaryContainer,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.smart_toy_outlined,
              color: AppColors.secondaryCyan,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pulse Coach Tip',
                  style: AppTypography.labelMd(color: AppColors.secondaryCyan).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Consume 30g fast-acting protein within 45m post-workout to optimize cellular repair.',
                  style: AppTypography.bodySm(color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
