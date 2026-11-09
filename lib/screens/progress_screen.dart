import 'package:flutter/material.dart';
import '../models/sample_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bar.dart';
import '../widgets/bar_chart_widget.dart';

class ProgressScreen extends StatefulWidget {
  final VoidCallback onNavigateToProfile;

  const ProgressScreen({
    super.key,
    required this.onNavigateToProfile,
  });

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen>
    with SingleTickerProviderStateMixin {
  String _selectedFilter = '7 Days';
  final List<String> _filters = ['7 Days', '30 Days', '3 Months', 'All Time'];

  late AnimationController _progressAnimController;
  late Animation<double> _consistencyAnim;

  @override
  void initState() {
    super.initState();
    _progressAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _consistencyAnim = CurvedAnimation(
      parent: _progressAnimController,
      curve: Curves.easeOutCubic,
    );
    _progressAnimController.forward();
  }

  @override
  void dispose() {
    _progressAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FitPulseAppBar(
        subtitle: 'Progress',
        onProfileTap: widget.onNavigateToProfile,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subtitle & Header Row
            _buildHeaderSection(),
            const SizedBox(height: 14),

            // Time Range Filter Pills
            _buildTimeFilterPills(),
            const SizedBox(height: 16),

            // Interactive 7-Day Performance Bar Chart Card
            _buildPerformanceChartCard(),
            const SizedBox(height: 16),

            // Consistency & Monthly Milestones Card
            _buildConsistencyCard(),
            const SizedBox(height: 20),

            // Personal Records (PR) Section
            _buildPersonalRecordsSection(),
            const SizedBox(height: 16),

            // Visual Coaching Note / Momentum Callout
            _buildCoachingIntelligenceCard(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.insights_rounded,
              color: AppColors.primaryLime,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Analytics & Records',
              style: AppTypography.headlineSm().copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            'WEEK 42',
            style: AppTypography.labelSm(color: AppColors.onSurfaceVariant).copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeFilterPills() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: _filters.map((filter) {
          final isSelected = filter == _selectedFilter;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilter = filter;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryLime : AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(999),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primaryLime.withOpacity(0.35),
                          blurRadius: 12,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                filter,
                style: AppTypography.labelMd(
                  color: isSelected ? AppColors.onPrimary : AppColors.onSurfaceVariant,
                ).copyWith(fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPerformanceChartCard() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'WEEKLY CALORIC & LOAD DISTRIBUTION',
                    style: AppTypography.labelSm(color: AppColors.onSurfaceVariant).copyWith(
                      fontSize: 9,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Daily Volume',
                    style: AppTypography.headlineMd().copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLime,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryLime.withOpacity(0.6),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'PEAK THU',
                      style: AppTypography.labelSm(color: AppColors.primaryLime).copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Bar Chart Visual Frame with Animated Bars & Floating Tooltip
          WeeklyBarChartWidget(
            bars: SampleData.weeklyBarData,
          ),
          const SizedBox(height: 16),

          // Aggregate Telemetry Stats Row
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surfaceLow,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                _buildAggregateStat('TOTAL VOLUME', '42,850', 'kg'),
                Container(width: 1, height: 32, color: AppColors.outline),
                _buildAggregateStat('WORKOUTS', '5', 'Sets'),
                Container(width: 1, height: 32, color: AppColors.outline),
                _buildAggregateStat('AVG DURATION', '52', 'min'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAggregateStat(String label, String value, String unit) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.labelSm(color: AppColors.onSurfaceVariant).copyWith(
              fontSize: 9,
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              text: value,
              style: AppTypography.headlineSm(color: AppColors.textPrimary).copyWith(
                fontWeight: FontWeight.w700,
              ),
              children: [
                TextSpan(
                  text: ' $unit',
                  style: AppTypography.labelSm(color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsistencyCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: AppColors.surfaceContainerHigh,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.verified_rounded,
                      color: AppColors.primaryLime,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CONSISTENCY TARGET',
                        style: AppTypography.labelSm(color: AppColors.onSurfaceVariant),
                      ),
                      Text(
                        'October Commitment',
                        style: AppTypography.headlineSm().copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                '90%',
                style: AppTypography.metricMd(color: AppColors.primaryLime),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Animated Progress Track Bar
          AnimatedBuilder(
            animation: _consistencyAnim,
            builder: (context, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  height: 10,
                  width: double.infinity,
                  color: AppColors.surfaceContainerHighest,
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.90 * _consistencyAnim.value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryLime,
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryLime.withOpacity(0.5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),

          // Details row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '18 of 20 Workouts Completed',
                style: AppTypography.bodySm(color: AppColors.onSurfaceVariant),
              ),
              Text(
                '2 workouts left',
                style: AppTypography.labelSm(color: AppColors.textPrimary).copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalRecordsSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLime.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.emoji_events_rounded,
                    color: AppColors.primaryLime,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Personal Records',
                  style: AppTypography.headlineSm().copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Text(
              'HISTORY (14)',
              style: AppTypography.labelSm(color: AppColors.primaryLime).copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Record Items
        ...SampleData.personalRecords.map((pr) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.outline),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: AppColors.surfaceContainerHigh,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(pr.icon, color: pr.iconColor, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              pr.exercise,
                              style: AppTypography.labelLg().copyWith(fontWeight: FontWeight.w700),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (pr.badgeText.isNotEmpty) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: pr.badgeColor?.withOpacity(0.2) ?? AppColors.surfaceVariant,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                pr.badgeText,
                                style: AppTypography.labelSm(
                                  color: pr.badgeColor ?? AppColors.primaryLime,
                                ).copyWith(fontWeight: FontWeight.w800, fontSize: 9),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        pr.subtitle,
                        style: AppTypography.bodySm(color: AppColors.onSurfaceVariant),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: pr.recordValue,
                        style: AppTypography.metricMd(),
                        children: [
                          TextSpan(
                            text: ' ${pr.recordUnit}',
                            style: AppTypography.bodySm(color: AppColors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      pr.recordType,
                      style: AppTypography.labelSm(
                        color: pr.badgeColor != null ? pr.badgeColor! : AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildCoachingIntelligenceCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.outline),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryLime.withOpacity(0.5), width: 1.5),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              SampleData.coachAvatarUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.person,
                color: AppColors.primaryLime,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FITPULSE INTELLIGENCE',
                  style: AppTypography.labelSm(color: AppColors.primaryLime).copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    text: 'Deadlift progression is up ',
                    style: AppTypography.bodySm(color: AppColors.textPrimary),
                    children: [
                      TextSpan(
                        text: '+4.8% ',
                        style: AppTypography.bodySm(color: AppColors.primaryLime).copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const TextSpan(
                        text: 'this cycle. Keep rest intervals at 3 min for upcoming heavy triples.',
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
}
