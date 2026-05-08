import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fintech_ui/l10n/generated/app_localizations.dart';
import '../../../core/constants/app_colors.dart';
import '../../../models/card_model.dart';
import '../../../providers/app_providers.dart';

import '../../../core/constants/assets.dart';

/// A horizontal page slider displaying credit cards with selection animation.
class CardSlider extends ConsumerStatefulWidget {
  final ValueChanged<int> onPageChanged;

  const CardSlider({
    super.key,
    required this.onPageChanged,
  });

  @override
  ConsumerState<CardSlider> createState() => _CardSliderState();
}

class _CardSliderState extends ConsumerState<CardSlider> {
  int _currentIndex = 1;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 1,
      viewportFraction: 0.8,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardsAsync = ref.watch(cardsStreamProvider);

    return cardsAsync.when(
      data: (cards) {
        if (cards.isEmpty) {
          return SizedBox(
            height: 220,
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.noTransactions,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary.withValues(alpha: 0.5),
                    ),
              ),
            ),
          );
        }
        return SizedBox(
          height: 220,
          child: PageView.builder(
            controller: _pageController,
            itemCount: cards.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
              widget.onPageChanged(index);
            },
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final isSelected = index == _currentIndex;
              return AnimatedScale(
                scale: isSelected ? 1.0 : 0.88,
                duration: AppDurations.fast,
                curve: Curves.easeOut,
                child: _buildCreditCard(cards[index]),
              );
            },
          ),
        );
      },
      loading: () => const SizedBox(
        height: 220,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) => SizedBox(
        height: 220,
        child: Center(
          child: Text(
            'Error loading cards',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreditCard(CardModel card) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
        image: const DecorationImage(
          image: AssetImage(Assets.assetsImagesCardBackground),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.assetsSvgsChip,
                    width: 36,
                    height: 26,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 10),
                  SvgPicture.asset(
                    Assets.assetsSvgsContactless,
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    Assets.assetsSvgsMastercard,
                    width: 36,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    AppLocalizations.of(context)!.mastercard,
                    style: TextStyle(
                      fontSize: 6,
                      color: AppColors.textSecondary.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              card.number,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 18,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.cardHolder,
                    style: TextStyle(
                      fontSize: 9,
                      color: AppColors.textSecondary.withValues(alpha: 0.4),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    card.holder,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.validThru,
                    style: TextStyle(
                      fontSize: 9,
                      color: AppColors.textSecondary.withValues(alpha: 0.4),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    card.valid,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.cvv,
                    style: TextStyle(
                      fontSize: 9,
                      color: AppColors.textSecondary.withValues(alpha: 0.4),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    card.cvv,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
