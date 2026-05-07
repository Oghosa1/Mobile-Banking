import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fintech_ui/l10n/generated/app_localizations.dart';
import '../../../core/constants/app_colors.dart';
import '../../../viewmodels/cards_viewmodel.dart';
import '../widgets/card_slider.dart';
import '../widgets/card_actions.dart';
import '../widgets/card_settings_list.dart';

class CardsScreen extends ConsumerWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardsState = ref.watch(cardsViewModelProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.yourCard,
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                          ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.more_horiz,
                        color: AppColors.textPrimary,
                        size: 24,
                      ),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '2 Physical Card, 1 Virtual Card',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                        color: AppColors.textSecondary.withValues(alpha: 0.5),
                      ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _buildTypePill(context, ref, 'Physical Card', l10n.physicalCard, cardsState.selectedCardType),
                    const SizedBox(width: 12),
                    _buildTypePill(context, ref, 'Virtual Card', l10n.virtualCard, cardsState.selectedCardType),
                  ],
                ),
                const SizedBox(height: 24),
                CardSlider(
                  onPageChanged: (index) {
                    ref.read(cardsViewModelProvider.notifier).setCurrentCardIndex(index);
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => AnimatedContainer(
                      duration: AppDurations.fast,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: index == cardsState.currentCardIndex ? 20 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: index == cardsState.currentCardIndex
                            ? AppColors.primary
                            : AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                const CardActions(),
                const SizedBox(height: 28),
                const CardSettingsList(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypePill(
    BuildContext context,
    WidgetRef ref,
    String typeKey,
    String localizedLabel,
    String selectedCardType,
  ) {
    final bool isSelected = selectedCardType == typeKey;
    return GestureDetector(
      onTap: () {
        ref.read(cardsViewModelProvider.notifier).setSelectedCardType(typeKey);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surface : AppColors.surfaceLight.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Text(
          localizedLabel,
          style: TextStyle(
            color: isSelected ? AppColors.textPrimary : AppColors.textSecondary.withValues(alpha: 0.4),
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
