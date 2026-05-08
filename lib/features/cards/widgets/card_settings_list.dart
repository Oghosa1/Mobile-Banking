import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fintech_ui/l10n/generated/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/assets.dart';
import '../../../viewmodels/cards_viewmodel.dart';
import '../views/card_transaction_screen.dart';

/// A list of card settings with toggles and navigation options.
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
          style: GoogleFonts.arimo(
            textStyle: Theme.of(context).textTheme.headlineMedium,
            fontWeight: FontWeight.normal,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 16),
        _buildSettingItem(
          context,
          svgPath: Assets.assetsSvgsChangePin,
          title: l10n.changePin,
          hasToggle: true,
          toggleValue: cardsState.changePin,
          onToggleChanged: (val) {
            ref.read(cardsViewModelProvider.notifier).toggleChangePin(val);
          },
        ),
        _buildSettingItem(
          context,
          svgPath: Assets.assetsSvgsQrPayment,
          title: l10n.qrPayment,
          hasToggle: true,
          toggleValue: cardsState.qrPayment,
          onToggleChanged: (val) {
            ref.read(cardsViewModelProvider.notifier).toggleQrPayment(val);
          },
        ),
        _buildSettingItem(
          context,
          svgPath: Assets.assetsSvgsOnlineShopping,
          title: l10n.onlineShopping,
          hasToggle: true,
          toggleValue: cardsState.onlineShopping,
          onToggleChanged: (val) {
            ref.read(cardsViewModelProvider.notifier).toggleOnlineShopping(val);
          },
        ),
        _buildSettingItem(
          context,
          svgPath: Assets.assetsSvgsCardTransactions,
          title: l10n.cardTransactions,
          hasToggle: false,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CardTransactionScreen(),
              ),
            );
          },
        ),
        _buildSettingItem(
          context,
          svgPath: Assets.assetsSvgsContactless,
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
    IconData? icon,
    String? svgPath,
    required String title,
    required bool hasToggle,
    bool toggleValue = false,
    ValueChanged<bool>? onToggleChanged,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
            if (svgPath != null)
              SvgPicture.asset(
                svgPath,
                width: 22,
                height: 30,
                colorFilter: const ColorFilter.mode(
                  AppColors.textPrimary,
                  BlendMode.srcIn,
                ),
              )
            else if (icon != null)
              Icon(icon, color: AppColors.textPrimary, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.arimo(
                  textStyle: Theme.of(context).textTheme.headlineMedium,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
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
                inactiveThumbColor: AppColors.textSecondary.withValues(
                  alpha: 0.3,
                ),
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
      ),
    );
  }
}
