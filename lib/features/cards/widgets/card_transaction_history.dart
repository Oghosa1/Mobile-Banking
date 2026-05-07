import 'package:flutter/material.dart';
import 'package:fintech_ui/l10n/generated/app_localizations.dart';
import '../../../core/constants/app_colors.dart';

/// A custom widget displaying transaction history for the active card.
class CardTransactionHistory extends StatelessWidget {
  const CardTransactionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.transactionHistory,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                l10n.seeAll,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildTransactionItem(
          context,
          title: 'E wallet',
          subtitle: '12:10 pm · 12-12-20024',
          amount: '+ 100',
          isCredit: true,
          icon: Icons.account_balance_wallet_outlined,
        ),
        _buildTransactionItem(
          context,
          title: 'Online Shopping',
          subtitle: '12:10 pm · 12-12-20024',
          amount: '- 100',
          isCredit: false,
          icon: Icons.shopping_bag_outlined,
        ),
      ],
    );
  }

  Widget _buildTransactionItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String amount,
    required bool isCredit,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.05),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
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
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary.withValues(alpha: 0.5),
                        fontSize: 11,
                      ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isCredit ? AppColors.primary : AppColors.debitRed,
                ),
          ),
        ],
      ),
    );
  }
}
