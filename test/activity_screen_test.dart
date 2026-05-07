import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fintech_ui/main.dart';
import 'package:fintech_ui/providers/app_providers.dart';
import 'package:fintech_ui/services/mock_data_service.dart';
import 'package:fintech_ui/models/card_model.dart';
import 'package:fintech_ui/models/transaction_model.dart';
import 'package:fintech_ui/features/activity/views/activity_screen.dart';

class ActivityStaticMockDataService implements MockDataService {
  @override
  Stream<String> get userNameStream => Stream.value('Tayyab Sohail');

  @override
  Stream<double> get balanceStream => Stream.value(1200.0);

  @override
  Stream<List<TransactionModel>> get transactionStream => Stream.value([
        const TransactionModel(
          id: 't_1',
          title: 'E wallet',
          subtitle: 'Feb 12 2024 at 10:24 pm',
          amount: '120\$',
          isCredit: true,
          time: 'Today',
        ),
      ]);

  @override
  Stream<List<CardModel>> get cardsStream => Stream.value([
        const CardModel(
          id: 'card_1',
          number: '•••• •••• •••• 1124',
          holder: 'Tayyab Sohail',
          valid: '04 / 09 / 2027',
          cvv: '342',
          cardType: 'Physical Card',
        ),
      ]);
}

void main() {
  final testOverrides = [
    mockDataServiceProvider.overrideWithValue(ActivityStaticMockDataService()),
  ];

  setUp(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('Navigating to ActivityScreen displays content', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: testOverrides,
        child: const FintechApp(),
      ),
    );

    // Verify on Dashboard screen
    expect(find.text('Transaction History'), findsOneWidget);

    // Tap Activity tab on bottom nav
    await tester.tap(find.byIcon(Icons.bar_chart));
    await tester.pumpAndSettle();

    // Verify ActivityScreen is displayed
    expect(find.byType(ActivityScreen), findsOneWidget);
    expect(find.text('My Activity'), findsOneWidget);
    expect(find.text('Total Spending'), findsOneWidget);
    expect(find.text('1200\$'), findsOneWidget);
    expect(find.text('Recent Transfer'), findsOneWidget);
    expect(find.text('E wallet'), findsOneWidget);
  });
}
