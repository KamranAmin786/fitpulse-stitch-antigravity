import 'package:flutter/material.dart';
import '../models/sample_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _hapticsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FitPulseAppBar(
        subtitle: 'Profile',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Header Card
            _buildProfileHeaderCard(),
            const SizedBox(height: 18),

            // Lifetime Performance (2x2 Grid)
            _buildLifetimePerformanceSection(),
            const SizedBox(height: 18),

            // Biometrics & Target Card
            _buildBiometricsCard(),
            const SizedBox(height: 18),

            // Settings & Configurations Section
            _buildSettingsSection(),
            const SizedBox(height: 18),

            // Account & Support Section
            _buildAccountSupportSection(),
            const SizedBox(height: 20),

            // Log Out Button & Version Footer
            _buildLogoutSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeaderCard() {
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
      child: Row(
        children: [
          // Avatar with gradient border & bolt badge
          Stack(
            children: [
              Container(
                width: 76,
                height: 76,
                padding: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.primaryLime,
                      AppColors.surfaceContainer,
                      AppColors.secondaryCyan,
                    ],
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(38),
                  child: Image.network(
                    SampleData.userAvatarUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.surfaceContainerHigh,
                      child: const Icon(
                        Icons.person,
                        color: AppColors.primaryLime,
                        size: 36,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLime,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.bolt_rounded,
                    color: AppColors.onPrimary,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),

          // User info & actions
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        SampleData.userName,
                        style: AppTypography.headlineMd().copyWith(fontWeight: FontWeight.w700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLime.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'PRO MEMBER',
                        style: AppTypography.labelSm(color: AppColors.primaryLime).copyWith(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  SampleData.userHandle,
                  style: AppTypography.bodySm(color: AppColors.onSurfaceVariant),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),

                // Edit Profile & Share Row
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.surfaceContainerHigh,
                        foregroundColor: AppColors.textPrimary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.tune_rounded, size: 14, color: AppColors.primaryLime),
                          const SizedBox(width: 6),
                          Text('Edit Profile', style: AppTypography.labelMd()),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.share_outlined, size: 18),
                        color: AppColors.textPrimary,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLifetimePerformanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'LIFETIME PERFORMANCE',
              style: AppTypography.labelSm(color: AppColors.onSurfaceVariant).copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              children: [
                const Icon(Icons.auto_graph_rounded, color: AppColors.primaryLime, size: 14),
                const SizedBox(width: 4),
                Text(
                  'All-Time',
                  style: AppTypography.labelSm(color: AppColors.primaryLime),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),

        // 2x2 Grid
        Row(
          children: [
            Expanded(
              child: _buildBentoTile(
                icon: Icons.fitness_center_rounded,
                iconColor: AppColors.primaryLime,
                tag: 'LOGGED',
                metric: '248',
                label: 'Workouts',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildBentoTile(
                icon: Icons.timelapse_rounded,
                iconColor: AppColors.secondaryCyan,
                tag: 'VOLUME',
                metric: '184.5',
                label: 'Hours Trained',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildBentoTile(
                icon: Icons.local_fire_department_rounded,
                iconColor: AppColors.primaryLime,
                tag: 'BURN',
                metric: '112.4k',
                label: 'Calories (kcal)',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildBentoTile(
                icon: Icons.electric_bolt_rounded,
                iconColor: AppColors.primaryLime,
                tag: 'RECORD',
                metric: '14',
                label: 'Active Streak',
                unit: 'days',
                isLimeMetric: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBentoTile({
    required IconData icon,
    required Color iconColor,
    required String tag,
    required String metric,
    required String label,
    String? unit,
    bool isLimeMetric = false,
  }) {
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
              Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              Text(
                tag,
                style: AppTypography.labelSm(
                  color: isLimeMetric ? AppColors.primaryLime : AppColors.onSurfaceVariant,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                metric,
                style: AppTypography.metricMd(
                  color: isLimeMetric ? AppColors.primaryLime : AppColors.textPrimary,
                ),
              ),
              if (unit != null) ...[
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: AppTypography.bodySm(color: AppColors.onSurfaceVariant),
                ),
              ],
            ],
          ),
          const SizedBox(height: 2),
          Text(
            label.toUpperCase(),
            style: AppTypography.labelSm(color: AppColors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildBiometricsCard() {
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
                  const Icon(
                    Icons.monitor_weight_outlined,
                    color: AppColors.primaryLime,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Biometrics & Target',
                    style: AppTypography.labelLg().copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Text(
                'Synched 2h ago',
                style: AppTypography.labelSm(color: AppColors.onSurfaceVariant),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 3 Columns
          Row(
            children: [
              Expanded(
                child: _buildBiometricCol('WEIGHT', '78.5', 'kg (Target 80)', AppColors.primaryLime),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildBiometricCol('BODY FAT', '13.8%', '-0.4% MoM', AppColors.secondaryCyan),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildBiometricCol('FOCUS TARGET', 'Hypertrophy', 'Lean Build', AppColors.tertiaryEmerald),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBiometricCol(String label, String value, String sub, Color subColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: AppTypography.labelSm(color: AppColors.onSurfaceVariant).copyWith(
              fontSize: 9,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTypography.headlineSm().copyWith(fontWeight: FontWeight.w700),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            sub,
            style: AppTypography.labelSm(color: subColor).copyWith(fontSize: 10),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SETTINGS & CONFIGURATIONS',
          style: AppTypography.labelSm(color: AppColors.onSurfaceVariant).copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),

        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.outline),
          ),
          child: Column(
            children: [
              _buildSettingTile(
                icon: Icons.tune_rounded,
                iconColor: AppColors.primaryLime,
                title: 'Workout Preferences',
                subtitle: 'Rest timers, auto-advance, units (kg)',
                trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.onSurfaceVariant),
              ),
              const Divider(height: 1, color: AppColors.divider, indent: 16, endIndent: 16),
              _buildSettingTile(
                icon: Icons.devices_other_rounded,
                iconColor: AppColors.secondaryCyan,
                title: 'Connected Health Apps',
                subtitle: 'Apple Health, Garmin, Strava',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLime.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '3 ACTIVE',
                        style: AppTypography.labelSm(color: AppColors.primaryLime).copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 9,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.chevron_right_rounded, color: AppColors.onSurfaceVariant),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.divider, indent: 16, endIndent: 16),
              // Rest Timer Haptics Toggle Switch
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.vibration_rounded,
                        color: AppColors.primaryLime,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rest Timer Haptics',
                            style: AppTypography.labelLg().copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Audio pulse & smart watch buzzer',
                            style: AppTypography.bodySm(color: AppColors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _hapticsEnabled,
                      activeThumbColor: AppColors.onPrimary,
                      activeTrackColor: AppColors.primaryLime,
                      inactiveThumbColor: AppColors.onSurfaceVariant,
                      inactiveTrackColor: AppColors.surfaceVariant,
                      onChanged: (val) {
                        setState(() {
                          _hapticsEnabled = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.divider, indent: 16, endIndent: 16),
              _buildSettingTile(
                icon: Icons.notifications_active_outlined,
                iconColor: AppColors.primaryLime,
                title: 'Daily Workout Reminder',
                subtitle: 'Scheduled for 07:00 AM weekdays',
                trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountSupportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ACCOUNT & SUPPORT',
          style: AppTypography.labelSm(color: AppColors.onSurfaceVariant).copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),

        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.outline),
          ),
          child: Column(
            children: [
              _buildSettingTile(
                icon: Icons.stars_rounded,
                iconColor: AppColors.primaryLime,
                title: 'FitPulse PRO Plan',
                subtitle: 'Annual pass • Renews Nov 2025',
                trailing: Text(
                  'MANAGE',
                  style: AppTypography.labelSm(color: AppColors.primaryLime).copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Divider(height: 1, color: AppColors.divider, indent: 16, endIndent: 16),
              _buildSettingTile(
                icon: Icons.forum_outlined,
                iconColor: AppColors.onSurfaceVariant,
                title: 'Community & Discord Hub',
                subtitle: 'Weekly challenges & coach AMA',
                trailing: const Icon(Icons.open_in_new_rounded, size: 18, color: AppColors.onSurfaceVariant),
              ),
              const Divider(height: 1, color: AppColors.divider, indent: 16, endIndent: 16),
              _buildSettingTile(
                icon: Icons.help_center_outlined,
                iconColor: AppColors.onSurfaceVariant,
                title: 'Help Center & FAQs',
                subtitle: 'Guides, contact trainers, diagnostics',
                trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.labelLg().copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  subtitle,
                  style: AppTypography.bodySm(color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _buildLogoutSection() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.surfaceContainerHigh,
                  content: Text(
                    'FitPulse: Account settings saved.',
                    style: AppTypography.bodyMd(color: AppColors.textPrimary),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.surfaceContainer,
              foregroundColor: AppColors.error,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
                side: const BorderSide(color: AppColors.outline),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.logout_rounded, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Log Out Account',
                  style: AppTypography.labelLg(color: AppColors.error).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'FitPulse v4.12.0 (Build 892) • Encrypted Telemetry',
          style: AppTypography.bodySm(color: AppColors.onSurfaceVariant).copyWith(
            fontSize: 11,
            color: AppColors.onSurfaceVariant.withOpacity(0.6),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
