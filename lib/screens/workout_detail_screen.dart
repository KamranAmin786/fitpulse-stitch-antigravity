import 'dart:async';
import 'package:flutter/material.dart';
import '../models/sample_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bar.dart';
import '../widgets/rest_timer_painter.dart';

class WorkoutDetailScreen extends StatefulWidget {
  final VoidCallback onNavigateToProfile;

  const WorkoutDetailScreen({
    super.key,
    required this.onNavigateToProfile,
  });

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  // Rest Timer State
  int _totalSeconds = 120;
  int _remainingSeconds = 75;
  Timer? _timer;
  bool _isMuted = false;

  // Exercise sets state
  late List<ExerciseDetail> _exercises;
  late TextEditingController _repsController;
  late TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    _exercises = SampleData.getInitialExercises();
    _repsController = TextEditingController(text: '8');
    _weightController = TextEditingController(text: '80');
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _add30Seconds() {
    setState(() {
      _remainingSeconds += 30;
      if (_remainingSeconds > _totalSeconds) {
        _totalSeconds = _remainingSeconds;
      }
    });
    if (_timer == null || !_timer!.isActive) {
      _startTimer();
    }
  }

  void _skipTimer() {
    setState(() {
      _remainingSeconds = 0;
    });
    _timer?.cancel();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
  }

  String _formatTimer(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  void _completeSet(int setIndex) {
    setState(() {
      final sets = _exercises[0].sets!;
      sets[setIndex].isCompleted = true;
      sets[setIndex].isActive = false;

      // Unlock next set if available
      if (setIndex + 1 < sets.length) {
        sets[setIndex + 1].isActive = true;
        sets[setIndex + 1].isLocked = false;
        _repsController.text = sets[setIndex + 1].reps.toString();
        _weightController.text = sets[setIndex + 1].weight.toStringAsFixed(0);
      }

      // Reset rest timer
      _remainingSeconds = 90;
      _totalSeconds = 90;
      _startTimer();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _repsController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FitPulseAppBar(
        subtitle: 'Workout',
        onProfileTap: widget.onNavigateToProfile,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Overview Card
            _buildOverviewCard(),
            const SizedBox(height: 14),

            // Active Rest Timer Live Card
            _buildRestTimerCard(),
            const SizedBox(height: 16),

            // Exercise 1: Barbell Incline Bench Press (Current Focus with Interactive Sets)
            _buildExercise1InteractiveCard(),
            const SizedBox(height: 14),

            // Exercise 2: Dumbbell Incline Chest Fly
            _buildSecondaryExerciseCard(_exercises[1]),
            const SizedBox(height: 14),

            // Exercise 3: Seated Cable Row
            _buildSecondaryExerciseCard(_exercises[2]),
            const SizedBox(height: 14),

            // Exercise 4: Tricep Rope Pushdown
            _buildSecondaryExerciseCard(_exercises[3]),
            const SizedBox(height: 20),

            // Bottom CTA Action Bar
            _buildBottomCtaButton(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outline),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tags and Action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLime.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      'HYPERTROPHY',
                      style: AppTypography.labelSm(color: AppColors.primaryLime).copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      'INTERMEDIATE',
                      style: AppTypography.labelSm(color: AppColors.onSurfaceVariant).copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz_rounded,
                  color: AppColors.onSurfaceVariant,
                ),
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Upper Body Strength Phase 1',
            style: AppTypography.headlineLg(),
          ),
          const SizedBox(height: 4),
          Text(
            '45 Min • 6 Exercises • 340 Est. kcal',
            style: AppTypography.bodySm(color: AppColors.onSurfaceVariant),
          ),
          const SizedBox(height: 14),

          // Quick Biometric Telemetry Snippet
          Row(
            children: [
              _buildTelemetryTile('TARGET VOLUME', '4,820', 'kg', isLime: false),
              const SizedBox(width: 8),
              _buildTelemetryTile('AVG PACE', '68', 's/set', isLime: true),
              const SizedBox(width: 8),
              _buildTelemetryTile('SETS LEFT', '12 / 14', '', isLime: false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTelemetryTile(String label, String value, String unit, {required bool isLime}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surfaceLow,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTypography.labelSm(color: AppColors.onSurfaceVariant).copyWith(
                fontSize: 9,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                text: value,
                style: AppTypography.metricMd(
                  color: isLime ? AppColors.primaryLime : AppColors.textPrimary,
                ),
                children: [
                  if (unit.isNotEmpty)
                    TextSpan(
                      text: ' $unit',
                      style: AppTypography.bodySm(color: AppColors.onSurfaceVariant),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestTimerCard() {
    final double progress = _totalSeconds > 0
        ? (_remainingSeconds / _totalSeconds).clamp(0.0, 1.0)
        : 0.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.outline),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Radial Timer Countdown with icon
              Row(
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          size: const Size(48, 48),
                          painter: RestTimerRingPainter(progress: progress),
                        ),
                        const Icon(
                          Icons.timer_outlined,
                          color: AppColors.primaryLime,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ACTIVE REST WINDOW',
                        style: AppTypography.labelSm(color: AppColors.primaryLime).copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            _formatTimer(_remainingSeconds),
                            style: AppTypography.metricLg(),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'rem',
                            style: AppTypography.labelSm(color: AppColors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              // Control buttons
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _add30Seconds,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surfaceVariant,
                      foregroundColor: AppColors.textPrimary,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.add, size: 14),
                        const SizedBox(width: 2),
                        Text('30s', style: AppTypography.labelMd()),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: _skipTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surfaceContainerHigh,
                      foregroundColor: AppColors.onSurfaceVariant,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: Text('Skip', style: AppTypography.labelMd()),
                  ),
                  const SizedBox(width: 6),
                  IconButton(
                    onPressed: _toggleMute,
                    icon: Icon(
                      _isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                      color: AppColors.onSurfaceVariant,
                      size: 20,
                    ),
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Linear timer bar
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Container(
              height: 4,
              width: double.infinity,
              color: AppColors.surfaceVariant,
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress,
                child: Container(
                  color: AppColors.primaryLime,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExercise1InteractiveCard() {
    final exercise = _exercises[0];
    final sets = exercise.sets!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLow,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(exercise.icon, color: exercise.iconColor, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          exercise.number.toUpperCase(),
                          style: AppTypography.labelSm(color: AppColors.primaryLime).copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            exercise.category,
                            style: AppTypography.labelSm(color: AppColors.onSurfaceVariant),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      exercise.name,
                      style: AppTypography.headlineSm().copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.onSurfaceVariant,
                  size: 20,
                ),
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Sets Table Column Headers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 36,
                  child: Text('SET', style: AppTypography.labelSm(color: AppColors.onSurfaceVariant)),
                ),
                Expanded(
                  child: Center(
                    child: Text('PREVIOUS', style: AppTypography.labelSm(color: AppColors.onSurfaceVariant)),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text('REPS × WEIGHT', style: AppTypography.labelSm(color: AppColors.onSurfaceVariant)),
                  ),
                ),
                SizedBox(
                  width: 44,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('LOG', style: AppTypography.labelSm(color: AppColors.onSurfaceVariant)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Sets Rows
          ...List.generate(sets.length, (idx) {
            final s = sets[idx];
            return Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: s.isActive
                    ? AppColors.surfaceContainerHigh
                    : AppColors.surfaceLow.withOpacity(s.isLocked ? 0.6 : 1.0),
                borderRadius: BorderRadius.circular(14),
                border: s.isActive
                    ? Border.all(color: AppColors.primaryLime.withOpacity(0.5))
                    : null,
              ),
              child: Row(
                children: [
                  // Set Number
                  SizedBox(
                    width: 36,
                    child: Row(
                      children: [
                        if (s.isActive)
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.only(right: 4),
                            decoration: const BoxDecoration(
                              color: AppColors.primaryLime,
                              shape: BoxShape.circle,
                            ),
                          ),
                        Text(
                          s.setNumber,
                          style: AppTypography.labelMd(
                            color: s.isActive ? AppColors.primaryLime : AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Previous Weight
                  Expanded(
                    child: Center(
                      child: Text(
                        s.previous,
                        style: AppTypography.bodySm(color: AppColors.onSurfaceVariant),
                      ),
                    ),
                  ),

                  // Reps x Weight inputs / text
                  Expanded(
                    child: s.isActive && !s.isCompleted
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 36,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceLowest,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: TextField(
                                  controller: _repsController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: AppTypography.labelMd(color: AppColors.textPrimary),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  onChanged: (val) {
                                    final v = int.tryParse(val);
                                    if (v != null) s.reps = v;
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                child: Text('×', style: TextStyle(color: AppColors.onSurfaceVariant)),
                              ),
                              Container(
                                width: 42,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceLowest,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: TextField(
                                  controller: _weightController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: AppTypography.labelMd(color: AppColors.textPrimary),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  onChanged: (val) {
                                    final v = double.tryParse(val);
                                    if (v != null) s.weight = v;
                                  },
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${s.reps}',
                                style: AppTypography.labelMd(
                                  color: s.isLocked ? AppColors.onSurfaceVariant : AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                ' × ',
                                style: AppTypography.bodySm(color: AppColors.onSurfaceVariant),
                              ),
                              Text(
                                '${s.weight.toInt()} kg',
                                style: AppTypography.labelMd(
                                  color: s.isLocked ? AppColors.onSurfaceVariant : AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                  ),

                  // Log / Check Action
                  SizedBox(
                    width: 44,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: s.isCompleted
                          ? Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryLime,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_rounded,
                                color: AppColors.onPrimary,
                                size: 18,
                              ),
                            )
                          : (s.isLocked
                              ? Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: AppColors.surfaceLowest,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.lock_outline_rounded,
                                    color: AppColors.onSurfaceVariant,
                                    size: 16,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () => _completeSet(idx),
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: AppColors.surfaceLowest,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.primaryLime,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.done_rounded,
                                      color: AppColors.primaryLime,
                                      size: 18,
                                    ),
                                  ),
                                )),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSecondaryExerciseCard(ExerciseDetail exercise) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLow,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(exercise.icon, color: exercise.iconColor, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          exercise.number.toUpperCase(),
                          style: AppTypography.labelSm(color: exercise.iconColor).copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            exercise.category,
                            style: AppTypography.labelSm(color: AppColors.onSurfaceVariant),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      exercise.name,
                      style: AppTypography.headlineSm().copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      exercise.targetSummary,
                      style: AppTypography.bodySm(color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.expand_more_rounded,
                color: AppColors.onSurfaceVariant,
                size: 24,
              ),
            ],
          ),
          if (exercise.summaryPills != null && exercise.summaryPills!.isNotEmpty) ...[
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: exercise.summaryPills!.map((pill) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      pill,
                      style: AppTypography.bodySm(color: AppColors.onSurface),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomCtaButton() {
    final sets = _exercises[0].sets!;
    final activeSetIndex = sets.indexWhere((s) => s.isActive && !s.isCompleted);
    final String ctaText = activeSetIndex != -1
        ? 'Continue Set ${activeSetIndex + 1} (${sets[activeSetIndex].weight.toInt()} kg)'
        : 'All Sets Completed!';

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: activeSetIndex != -1
            ? () => _completeSet(activeSetIndex)
            : () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.surfaceContainerHigh,
                    content: Text(
                      'Great job! Routine recorded.',
                      style: AppTypography.bodyMd(color: AppColors.primaryLime),
                    ),
                  ),
                );
              },
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
              size: 26,
            ),
            const SizedBox(width: 8),
            Text(
              ctaText,
              style: AppTypography.labelLg(color: AppColors.onPrimary).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
