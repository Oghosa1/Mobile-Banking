import 'package:flutter/material.dart';
import 'package:fintech_ui/l10n/generated/app_localizations.dart';
import '../../../core/constants/app_colors.dart';
import 'profile_header.dart';
import 'settings_item.dart';
import 'logout_button.dart';

/// A slide-out drawer displaying profile information and quick settings.
class ProfileDrawer extends StatefulWidget {
  const ProfileDrawer({super.key});

  @override
  State<ProfileDrawer> createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  bool _notificationToggle = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Drawer(
      width: 320,
      backgroundColor: AppColors.background,
      elevation: 16,
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: ProfileHeader(),
                ),
                const SizedBox(height: 14),
                Container(
                  height: 1,
                  color: AppColors.divider,
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.profileSettings,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontSize: 18,
                            ),
                      ),
                      const SizedBox(height: 12),
                      SettingsItem(
                        icon: Icons.description,
                        title: l10n.eStatement,
                        iconBorder: false,
                      ),
                      const SizedBox(height: 12),
                      SettingsItem(
                        icon: Icons.credit_card,
                        title: l10n.creditCard,
                        iconBorder: false,
                      ),
                      const SizedBox(height: 12),
                      SettingsItem(
                        icon: Icons.settings,
                        title: l10n.settings,
                        iconBorder: false,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.notification,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontSize: 18,
                            ),
                      ),
                      const SizedBox(height: 12),
                      SettingsItem(
                        icon: Icons.notifications,
                        title: l10n.appNotification,
                        hasToggle: true,
                        isToggleOn: _notificationToggle,
                        iconBorder: false,
                        onToggleChanged: (value) {
                          setState(() {
                            _notificationToggle = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.more,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontSize: 18,
                            ),
                      ),
                      const SizedBox(height: 12),
                      SettingsItem(
                        icon: Icons.language,
                        title: l10n.language,
                        iconBorder: false,
                      ),
                      const SizedBox(height: 12),
                      SettingsItem(
                        icon: Icons.public,
                        title: l10n.country,
                        iconBorder: false,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: LogoutButton(),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
