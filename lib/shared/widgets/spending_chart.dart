import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils.dart';

/// Mock chart data shared between the Activity and Card Transaction screens.
const List<FlSpot> kSpendingSpots = [
  FlSpot(0, 1.2),
  FlSpot(0.5, 2.2),
  FlSpot(1, 1.8),
  FlSpot(1.5, 2.5),
  FlSpot(2, 2.1),
  FlSpot(2.5, 3.2),
  FlSpot(3, 2.8),
  FlSpot(3.5, 3.0),
  FlSpot(4, 2.6),
  FlSpot(5, 4.0),
];

/// Mock amounts corresponding to each spot in [kSpendingSpots].
const List<int> kSpendingAmounts = [
  1250,
  2200,
  3657,
  2500,
  2100,
  3200,
  2800,
  3000,
  2600,
  4000,
];

/// An interactive line chart displaying spending data over time.
///
/// Manages its own selection state internally and notifies the parent
/// via [onSelectionChanged] when the user taps a different data point.
class SpendingChart extends StatefulWidget {
  final List<FlSpot> spots;
  final List<int> spotAmounts;
  final int initialSelectedIndex;
  final ValueChanged<int>? onSelectionChanged;

  const SpendingChart({
    super.key,
    required this.spots,
    required this.spotAmounts,
    this.initialSelectedIndex = 2,
    this.onSelectionChanged,
  });

  @override
  State<SpendingChart> createState() => _SpendingChartState();
}

class _SpendingChartState extends State<SpendingChart> {
  late int _selectedIndex;

  static const _axisLabelStyle = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  static const _monthLabels = {
    0: 'Jan',
    1: 'Feb',
    2: 'Mar',
    3: 'Apr',
    4: 'May',
    5: 'Jun',
  };

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialSelectedIndex;
  }

  void _onTouch(FlTouchEvent event, LineTouchResponse? response) {
    if (response == null ||
        response.lineBarSpots == null ||
        response.lineBarSpots!.isEmpty) {
      return;
    }
    final index = response.lineBarSpots!.first.spotIndex;
    if (index != _selectedIndex) {
      setState(() => _selectedIndex = index);
      widget.onSelectionChanged?.call(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 5,
          minY: 0,
          maxY: 5,
          titlesData: FlTitlesData(
            show: true,
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final label = _monthLabels[value.toInt()] ?? '';
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(label, style: _axisLabelStyle),
                  );
                },
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: widget.spots,
              isCurved: true,
              color: AppColors.primary,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  if (index == _selectedIndex) {
                    return FlDotCirclePainter(
                      radius: 6,
                      color: AppColors.primary,
                      strokeWidth: 3,
                      strokeColor: Colors.white,
                    );
                  }
                  return FlDotCirclePainter(radius: 0, color: Colors.transparent);
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.35),
                    AppColors.primary.withValues(alpha: 0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
          showingTooltipIndicators: [
            ShowingTooltipIndicators([
              LineBarSpot(
                LineChartBarData(spots: widget.spots),
                0,
                widget.spots[_selectedIndex],
              ),
            ]),
          ],
          lineTouchData: LineTouchData(
            enabled: true,
            handleBuiltInTouches: true,
            touchCallback: _onTouch,
            getTouchedSpotIndicator: (barData, spotIndexes) {
              return spotIndexes.map((_) {
                return TouchedSpotIndicatorData(
                  FlLine(
                    color: Colors.white.withValues(alpha: 0.25),
                    strokeWidth: 1.5,
                    dashArray: [4, 4],
                  ),
                  FlDotData(show: false),
                );
              }).toList();
            },
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => Colors.white,
              tooltipPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              tooltipMargin: 8,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((barSpot) {
                  return LineTooltipItem(
                    formatCurrency(widget.spotAmounts[barSpot.spotIndex]),
                    const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}
