import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fintech_ui/l10n/generated/app_localizations.dart';
import '../../../core/constants/app_colors.dart';
import '../../../viewmodels/cards_viewmodel.dart';

class CardSettingsList extends ConsumerWidget {
  const CardSettingsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardsState = ref.watch(cardsViewModelProvider);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.cardSettings,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
        ),
        const SizedBox(height: 16),
        _buildSettingItem(
          context,
          icon: Icons.password,
          title: l10n.changePin,
          hasToggle: true,
          toggleValue: cardsState.changePin,
          onToggleChanged: (val) {
            ref.read(cardsViewModelProvider.notifier).toggleChangePin(val);
          },
        ),
        _buildSettingItem(
          context,
          icon: Icons.qr_code_2,
          title: l10n.qrPayment,
          hasToggle: true,
          toggleValue: cardsState.qrPayment,
          onToggleChanged: (val) {
            ref.read(cardsViewModelProvider.notifier).toggleQrPayment(val);
          },
        ),
        _buildSettingItem(
          context,
          icon: Icons.store_outlined,
          title: l10n.onlineShopping,
          hasToggle: true,
          toggleValue: cardsState.onlineShopping,
          onToggleChanged: (val) {
            ref.read(cardsViewModelProvider.notifier).toggleOnlineShopping(val);
          },
        ),
        _buildSettingItem(
          context,
          icon: Icons.credit_card,
          title: l10n.cardTransactions,
          hasToggle: false,
        ),
        _buildSettingItem(
          context,
          icon: Icons.contactless_outlined,
          title: l10n.tapPay,
          hasToggle: true,
          toggleValue: cardsState.tapPay,
          onToggleChanged: (val) {
            ref.read(cardsViewModelProvider.notifier).toggleTapPay(val);
          },
        ),
      ],
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool hasToggle,
    bool toggleValue = false,
    ValueChanged<bool>? onToggleChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.textPrimary,
            size: 22,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
            ),
          ),
          if (hasToggle)
            Switch(
              value: toggleValue,
              onChanged: onToggleChanged,
              activeTrackColor: AppColors.primary,
              activeThumbColor: Colors.white,
              inactiveTrackColor: AppColors.surfaceLight,
              inactiveThumbColor: AppColors.textSecondary.withValues(alpha: 0.3),
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
            )
          else
            const Icon(
              Icons.chevron_right,
              color: AppColors.textPrimary,
              size: 20,
            ),
        ],
      ),
    );
  }
}
