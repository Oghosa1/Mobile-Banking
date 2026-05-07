import 'package:flutter/material.dart';
import 'package:fintech_ui/l10n/generated/app_localizations.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/profile_header.dart';
import '../widgets/settings_item.dart';
import '../widgets/settings_section.dart';
import '../widgets/logout_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationToggle = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 30),
                child: ProfileHeader(),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 1,
                  color: AppColors.divider,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 36),
                child: SettingsSection(
                  title: l10n.profileSettings,
                  children: [
                    SettingsItem(
                      icon: Icons.description,
                      title: l10n.eStatement,
                      iconBorder: false,
                    ),
                    const SizedBox(height: 17),
                    SettingsItem(
                      icon: Icons.credit_card,
                      title: l10n.creditCard,
                      iconBorder: false,
                    ),
                    const SizedBox(height: 17),
                    SettingsItem(
                      icon: Icons.settings,
                      title: l10n.settings,
                      iconBorder: false,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 36),
                child: SettingsSection(
                  title: l10n.notification,
                  children: [
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
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 36),
                child: SettingsSection(
                  title: l10n.more,
                  children: [
                    SettingsItem(
                      icon: Icons.language,
                      title: l10n.language,
                      iconBorder: false,
                    ),
                    const SizedBox(height: 17),
                    SettingsItem(
                      icon: Icons.public,
                      title: l10n.country,
                      iconBorder: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: LogoutButton(),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}