import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fintech_ui/l10n/generated/app_localizations.dart';
import '../../../core/constants/app_colors.dart';
import '../../../models/transaction_model.dart';
import '../../../providers/app_providers.dart';
import '../../../viewmodels/dashboard_viewmodel.dart';

/// A widget that displays a list of the user's recent transaction history
/// categorized by time frames (Weekly, Monthly, Today).
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
            GestureDetector(
              onTap: () {},
              child: Text(
                l10n.seeAll,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
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
              children: filtered
                  .map((tx) => _buildTransactionItem(context, tx))
                  .toList(),
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

  Widget _buildTransactionItem(BuildContext context, TransactionModel tx) {
    IconData getIcon(String title) {
      switch (title) {
        case 'E wallet':
          return Icons.account_balance_wallet_outlined;
        case 'Online Shopping':
          return Icons.shopping_bag_outlined;
        case 'Banking Fee':
          return Icons.account_balance_outlined;
        case 'Saving':
          return Icons.savings_outlined;
        default:
          return Icons.payment_outlined;
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.surface, width: 2),
            ),
            child: Icon(
              getIcon(tx.title),
              color: AppColors.textPrimary,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tx.subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
          Text(
            tx.amount,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: tx.isCredit ? AppColors.primary : AppColors.debitRed,
            ),
          ),
        ],
      ),
    );
  }
}
