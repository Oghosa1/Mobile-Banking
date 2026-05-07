import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool hasToggle;
  final bool isToggleOn;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onToggleChanged;
  final bool iconBorder;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    this.hasToggle = false,
    this.isToggleOn = false,
    this.onTap,
    this.onToggleChanged,
    this.iconBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hasToggle ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    border: iconBorder
                        ? Border.all(
                            color: AppColors.primary,
                            width: 2,
                          )
                        : null,
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.primary,
                    size: iconBorder ? 18 : 24,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            if (hasToggle)
              Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: isToggleOn,
                  onChanged: onToggleChanged,
                  activeThumbColor: Colors.white,
                  activeTrackColor: AppColors.primaryDark,
                  inactiveTrackColor: AppColors.surfaceLight,
                ),
              )
            else
              const Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}