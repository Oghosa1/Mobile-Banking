import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fintech_ui/l10n/generated/app_localizations.dart';
import '../../../core/constants/app_colors.dart';
import '../../../providers/app_providers.dart';
import '../../../viewmodels/cards_viewmodel.dart';
import '../../../models/card_model.dart';
import '../widgets/card_transaction_credit_card.dart';
import '../widgets/card_transaction_history.dart';

/// A premium screen displaying transaction history and spending charts for a specific card.
class CardTransactionScreen extends ConsumerWidget {
  const CardTransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardsAsync = ref.watch(cardsStreamProvider);
    final cardsState = ref.watch(cardsViewModelProvider);
    final l10n = AppLocalizations.of(context)!;

    final CardModel? activeCard = cardsAsync.maybeWhen(
      data: (cards) => cards.isNotEmpty
          ? cards[cardsState.currentCardIndex.clamp(0, cards.length - 1)]
          : null,
      orElse: () => null,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textPrimary,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.cardTransactions,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_horiz,
              color: AppColors.textPrimary,
              size: 24,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (activeCard != null)
                  CardTransactionCreditCard(card: activeCard)
                else
                  _buildCardShimmer(),
                const SizedBox(height: 28),
                _buildTotalSpendSection(context),
                const SizedBox(height: 32),
                const CardTransactionHistory(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardShimmer() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildTotalSpendSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Total Spend',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary.withValues(alpha: 0.7),
                        ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '30\$',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.05),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 16,
                      color: AppColors.textPrimary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Weekly',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        );
                        Widget text;
                        switch (value.toInt()) {
                          case 0:
                            text = const Text('Jan', style: style);
                            break;
                          case 1:
                            text = const Text('Feb', style: style);
                            break;
                          case 2:
                            text = const Text('Mar', style: style);
                            break;
                          case 3:
                            text = const Text('Apr', style: style);
                            break;
                          case 4:
                            text = const Text('May', style: style);
                            break;
                          case 5:
                            text = const Text('Jun', style: style);
                            break;
                          default:
                            text = const Text('', style: style);
                            break;
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: text,
                        );
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 5,
                minY: 0,
                maxY: 5,
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 1.2),
                      const FlSpot(0.5, 2.2),
                      const FlSpot(1, 1.8), // Feb
                      const FlSpot(1.5, 2.5),
                      const FlSpot(2, 2.1),
                      const FlSpot(2.5, 3.2),
                      const FlSpot(3, 2.8),
                      const FlSpot(3.5, 3.0),
                      const FlSpot(4, 2.6),
                      const FlSpot(5, 4.0),
                    ],
                    isCurved: true,
                    color: AppColors.primary,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        if (spot.x == 1) {
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
                      LineChartBarData(spots: [
                        const FlSpot(1, 1.8),
                      ]),
                      0,
                      const FlSpot(1, 1.8),
                    ),
                  ]),
                ],
                lineTouchData: LineTouchData(
                  enabled: false,
                  getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
                    return spotIndexes.map((spotIndex) {
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
                    getTooltipColor: (spot) => Colors.white,
                    tooltipPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    tooltipMargin: 8,
                    getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                      return touchedBarSpots.map((barSpot) {
                        return LineTooltipItem(
                          '\$3,657',
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
          ),
        ],
      ),
    );
  }
}
