import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fintech_ui/l10n/generated/app_localizations.dart';
import '../../../viewmodels/profile_viewmodel.dart';
import 'settings_item.dart';
import 'settings_section.dart';

/// A reusable settings list rendering the grouped settings options (Profile, Notification, More).
///
/// Watches [profileViewModelProvider] to synchronize the notification toggle state.
class ProfileSettingsList extends ConsumerWidget {
  const ProfileSettingsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isNotificationsEnabled = ref.watch(profileViewModelProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSection(
          title: l10n.profileSettings,
          children: [
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
        const SizedBox(height: 24),
        SettingsSection(
          title: l10n.notification,
          children: [
            SettingsItem(
              icon: Icons.notifications,
              title: l10n.appNotification,
              hasToggle: true,
              isToggleOn: isNotificationsEnabled,
              iconBorder: false,
              onToggleChanged: (value) {
                ref
                    .read(profileViewModelProvider.notifier)
                    .setNotificationsEnabled(value);
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        SettingsSection(
          title: l10n.more,
          children: [
            SettingsItem(
              icon: Icons.translate,
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
      ],
    );
  }
}
