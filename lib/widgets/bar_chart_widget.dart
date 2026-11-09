import 'package:flutter/material.dart';
import '../models/sample_data.dart';
import '../theme/app_theme.dart';

class WeeklyBarChartWidget extends StatefulWidget {
  final List<BarData> bars;
  final ValueChanged<BarData>? onBarSelected;

  const WeeklyBarChartWidget({
    super.key,
    required this.bars,
    this.onBarSelected,
  });

  @override
  State<WeeklyBarChartWidget> createState() => _WeeklyBarChartWidgetState();
}

class _WeeklyBarChartWidgetState extends State<WeeklyBarChartWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _heightAnim;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    // Default to Thursday (index 3, which is the peak)
    _selectedIndex = widget.bars.indexWhere((b) => b.isPeak);
    if (_selectedIndex == -1) _selectedIndex = 3;

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _heightAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutBack,
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _selectBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (widget.onBarSelected != null) {
      widget.onBarSelected!(widget.bars[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedBar = widget.bars[_selectedIndex];
    const double chartHeight = 160.0;

    return Column(
      children: [
        // Animated Floating Tooltip
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.only(bottom: 12),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryLime,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      selectedBar.tooltipText,
                      style: AppTypography.labelSm(color: AppColors.textPrimary),
                    ),
                  ],
                ),
              ),
              // Downward caret indicator
              Transform.translate(
                offset: const Offset(0, -4),
                child: Transform.rotate(
                  angle: 3.14159 / 4,
                  child: Container(
                    width: 8,
                    height: 8,
                    color: AppColors.surfaceContainerHighest,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Bars Container
        AnimatedBuilder(
          animation: _heightAnim,
          builder: (context, child) {
            return SizedBox(
              height: chartHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(widget.bars.length, (index) {
                  final bar = widget.bars[index];
                  final isSelected = index == _selectedIndex;
                  final currentHeight = (bar.heightRatio * chartHeight * _heightAnim.value)
                      .clamp(20.0, chartHeight);

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => _selectBar(index),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // The animated bar
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              height: currentHeight,
                              decoration: BoxDecoration(
                                color: isSelected || bar.isPeak
                                    ? AppColors.primaryLime
                                    : (bar.isRest
                                        ? AppColors.surfaceContainerHighest.withOpacity(0.4)
                                        : AppColors.surfaceVariant.withOpacity(0.8)),
                                borderRadius: BorderRadius.circular(999),
                                boxShadow: isSelected || bar.isPeak
                                    ? [
                                        BoxShadow(
                                          color: AppColors.primaryLime.withOpacity(0.45),
                                          blurRadius: 16,
                                          spreadRadius: 1,
                                        ),
                                      ]
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Day label
                            Text(
                              bar.day,
                              style: AppTypography.labelSm(
                                color: isSelected || bar.isPeak
                                    ? AppColors.primaryLime
                                    : AppColors.onSurfaceVariant,
                              ).copyWith(
                                fontWeight: isSelected || bar.isPeak
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          },
        ),
      ],
    );
  }
}
