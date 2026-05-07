import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class CardActions extends StatelessWidget {
  const CardActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(
          context,
          icon: Icons.ac_unit,
          label: 'Freeze Card',
        ),
        _buildActionButton(
          context,
          icon: Icons.visibility_off,
          label: 'Reveal',
        ),
        _buildActionButton(
          context,
          icon: Icons.ac_unit,
          label: 'Freeze Card',
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, {required IconData icon, required String label}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: const BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              customBorder: const CircleBorder(),
              child: Icon(
                icon,
                color: AppColors.textPrimary,
                size: 22,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                fontSize: 12,
              ),
        ),
      ],
    );
  }
}
