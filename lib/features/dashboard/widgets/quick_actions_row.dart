import 'package:flutter/material.dart';
import 'package:fintech_ui/l10n/generated/app_localizations.dart';
import '../../../core/constants/app_colors.dart';

/// A row of quick action buttons for daily transactions such as
/// Bill Pay, Donations, Deposit, and More.
class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: _buildActionItem(
              context,
              icon: Icons.phone_iphone,
              label: l10n.billPay,
            ),
          ),
          _buildDivider(),
          Expanded(
            child: _buildActionItem(
              context,
              icon: Icons.volunteer_activism,
              label: l10n.donations,
            ),
          ),
          _buildDivider(),
          Expanded(
            child: _buildActionItem(
              context,
              icon: Icons.savings,
              label: l10n.deposit,
            ),
          ),
          _buildDivider(),
          Expanded(
            child: _buildActionItem(
              context,
              icon: Icons.grid_view,
              label: l10n.more,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, {required IconData icon, required String label}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: AppColors.surfaceLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.textPrimary,
                size: 20,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 32,
      color: AppColors.surfaceLight,
    );
  }
}
