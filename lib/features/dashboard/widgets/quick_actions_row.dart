import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fintech_ui/l10n/generated/app_localizations.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/assets.dart';

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
              svgPath: Assets.assetsSvgsBill,
              label: l10n.billPay,
            ),
          ),
          _buildDivider(),
          Expanded(
            child: _buildActionItem(
              context,
              svgPath: Assets.assetsSvgsDonation,
              label: l10n.donations,
            ),
          ),
          _buildDivider(),
          Expanded(
            child: _buildActionItem(
              context,
              svgPath: Assets.assetsSvgsDeposit,
              label: l10n.deposit,
            ),
          ),
          _buildDivider(),
          Expanded(
            child: _buildActionItem(
              context,
              svgPath: Assets.assetsSvgsMore,
              label: l10n.more,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, {required String svgPath, required String label}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              svgPath,
              width: 44,
              height: 44,
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
