import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../profile/widgets/profile_drawer.dart';
import '../widgets/greeting_header.dart';
import '../widgets/balance_card.dart';
import '../widgets/quick_actions_row.dart';
import '../widgets/transaction_list.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const ProfileDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                GreetingHeader(),
                SizedBox(height: 28),
                BalanceCard(),
                SizedBox(height: 24),
                QuickActionsRow(),
                SizedBox(height: 28),
                TransactionList(),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
