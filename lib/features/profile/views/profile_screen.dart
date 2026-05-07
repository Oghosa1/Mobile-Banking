import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_settings_list.dart';
import '../widgets/logout_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 36),
                child: ProfileSettingsList(),
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