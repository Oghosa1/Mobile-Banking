import 'package:flutter/material.dart';
import '../../../models/card_model.dart';
import '../../../core/constants/app_colors.dart';

/// A custom credit card widget used specifically on the transaction details screen.
class CardTransactionCreditCard extends StatelessWidget {
  final CardModel card;

  const CardTransactionCreditCard({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
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
                  Container(
                    width: 36,
                    height: 26,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700).withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: GridView.count(
                      crossAxisCount: 3,
                      padding: const EdgeInsets.all(2),
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                        9,
                        (index) => Container(
                          margin: const EdgeInsets.all(0.5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black.withValues(alpha: 0.1),
                              width: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.contactless,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                          color: AppColors.mastercardRed,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(-6, 0),
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: AppColors.mastercardOrange.withValues(alpha: 0.85),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'mastercard',
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
                    'Card Holder',
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
                    'Valid',
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
                    'CVV',
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
