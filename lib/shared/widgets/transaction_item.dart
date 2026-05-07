import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../models/transaction_model.dart';

/// A single row displaying a transaction's icon, title, subtitle, and amount.
class TransactionItem extends StatelessWidget {
  final TransactionModel tx;

  const TransactionItem({super.key, required this.tx});

  static IconData _getIcon(String title) {
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

  @override
  Widget build(BuildContext context) {
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
              _getIcon(tx.title),
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
