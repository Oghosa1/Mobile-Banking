import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fintech_ui/l10n/generated/app_localizations.dart';
import '../../../core/constants/app_colors.dart';
import '../../../providers/app_providers.dart';
import '../../../viewmodels/dashboard_viewmodel.dart';
import '../../../shared/widgets/transaction_item.dart';
import '../../activity/views/activity_screen.dart';

class TransactionList extends ConsumerWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(dashboardViewModelProvider);
    final transactionsAsync = ref.watch(transactionStreamProvider);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.transactionHistory,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              l10n.seeAll,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildFilterPill(
              context,
              ref: ref,
              filterKey: 'Weekly',
              localizedLabel: l10n.weekly,
              selectedFilter: selectedFilter,
            ),
            const SizedBox(width: 10),
            _buildFilterPill(
              context,
              ref: ref,
              filterKey: 'Monthly',
              localizedLabel: l10n.monthly,
              selectedFilter: selectedFilter,
            ),
            const SizedBox(width: 10),
            _buildFilterPill(
              context,
              ref: ref,
              filterKey: 'Today',
              localizedLabel: l10n.today,
              selectedFilter: selectedFilter,
            ),
          ],
        ),
        const SizedBox(height: 16),
        transactionsAsync.when(
          data: (transactions) {
            final filtered = transactions
                .where((tx) => tx.time == selectedFilter)
                .toList();
            if (filtered.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(
                    '${l10n.noTransactions} for $selectedFilter',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              );
            }
            return Column(
              children: filtered.map((tx) => TransactionItem(tx: tx)).toList(),
            );
          },
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (err, stack) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Text(
                l10n.errorLoading,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterPill(
    BuildContext context, {
    required WidgetRef ref,
    required String filterKey,
    required String localizedLabel,
    required String selectedFilter,
  }) {
    final bool isSelected = selectedFilter == filterKey;
    return GestureDetector(
      onTap: () {
        ref.read(dashboardViewModelProvider.notifier).setFilter(filterKey);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surfaceLight : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          localizedLabel,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: isSelected
                ? AppColors.textPrimary
                : AppColors.textSecondary.withValues(alpha: 0.5),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
