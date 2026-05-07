import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class CardSlider extends StatefulWidget {
  final ValueChanged<int> onPageChanged;

  const CardSlider({
    super.key,
    required this.onPageChanged,
  });

  @override
  State<CardSlider> createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> {
  int _currentIndex = 1;
  late final PageController _pageController;

  final List<Map<String, String>> _cards = [
    {
      'number': '•••• •••• •••• 1124',
      'holder': 'Tayyab Sohail',
      'valid': '04 / 09 / 2027',
      'cvv': '342',
    },
    {
      'number': '•••• •••• •••• 3466',
      'holder': 'Tayyab Sohail',
      'valid': '12 / 02 / 2024',
      'cvv': '663',
    },
    {
      'number': '•••• •••• •••• 8851',
      'holder': 'Tayyab Sohail',
      'valid': '08 / 11 / 2029',
      'cvv': '904',
    },
  ];

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
    return SizedBox(
      height: 220,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _cards.length,
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
            child: _buildCreditCard(_cards[index]),
          );
        },
      ),
    );
  }

  Widget _buildCreditCard(Map<String, String> cardData) {
    return Container(
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
                    child: Stack(
                      children: [
                        Positioned.fill(
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
                      ],
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
                          color: Color(0xFFFF0015),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(-6, 0),
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF9900).withValues(alpha: 0.85),
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
              cardData['number']!,
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
                    cardData['holder']!,
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
                    cardData['valid']!,
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
                    cardData['cvv']!,
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
