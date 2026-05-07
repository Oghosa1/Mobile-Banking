import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fintech_ui/main.dart';
import 'package:fintech_ui/providers/app_providers.dart';
import 'package:fintech_ui/services/mock_data_service.dart';
import 'package:fintech_ui/models/card_model.dart';
import 'package:fintech_ui/models/transaction_model.dart';

class StaticMockDataService implements MockDataService {
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
    mockDataServiceProvider.overrideWithValue(StaticMockDataService()),
  ];

  setUp(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('App launches with Home/Dashboard screen by default', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: testOverrides,
        child: const FintechApp(),
      ),
    );

    // Verify that the Dashboard Greeting header is present.
    expect(find.textContaining('Welcome', findRichText: true), findsOneWidget);

    // Verify that the Transaction History section is present.
    expect(find.text('Transaction History'), findsOneWidget);
  });

  testWidgets('Tapping Profile tab navigates to the Profile screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: testOverrides,
        child: const FintechApp(),
      ),
    );

    // Tap on the Profile navigation tab.
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    // Verify that the Profile Screen elements are now visible.
    expect(find.text('Profile Settings'), findsOneWidget);
  });

  testWidgets('Tapping Hamburger menu icon opens the Profile Drawer', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: testOverrides,
        child: const FintechApp(),
      ),
    );

    // Tap on the Hamburger menu icon.
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verify that the Profile Drawer is open.
    expect(find.text('Profile Settings'), findsOneWidget);
  });

  testWidgets('Tapping Cards tab navigates to Cards screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: testOverrides,
        child: const FintechApp(),
      ),
    );

    // Tap on the Cards navigation tab.
    await tester.tap(find.byIcon(Icons.credit_card));
    await tester.pumpAndSettle();

    // Verify that the Cards Screen is displayed.
    expect(find.text('Your Card'), findsOneWidget);
    expect(find.text('Card Settings'), findsOneWidget);
  });
}
