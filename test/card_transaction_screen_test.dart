import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fintech_ui/main.dart';
import 'package:fintech_ui/providers/app_providers.dart';
import 'package:fintech_ui/services/mock_data_service.dart';
import 'package:fintech_ui/models/card_model.dart';
import 'package:fintech_ui/models/transaction_model.dart';
import 'package:fintech_ui/features/cards/views/card_transaction_screen.dart';

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
        const CardModel(
          id: 'card_2',
          number: '•••• •••• •••• 3466',
          holder: 'Tayyab Sohail',
          valid: '12 / 02 / 2024',
          cvv: '663',
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

  testWidgets('Tapping Card Transactions setting navigates to CardTransactionScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: testOverrides,
        child: const FintechApp(),
      ),
    );

    // Navigate to Cards screen
    await tester.tap(find.byIcon(Icons.credit_card));
    await tester.pumpAndSettle();

    // Tap Card Transactions setting
    final cardTxFinder = find.text('Card Transactions');
    await tester.ensureVisible(cardTxFinder);
    await tester.tap(cardTxFinder);
    await tester.pumpAndSettle();

    // Verify CardTransactionScreen is displayed
    expect(find.byType(CardTransactionScreen), findsOneWidget);
    expect(find.text('Card Transactions'), findsOneWidget);
    expect(find.text('Total Spend'), findsOneWidget);
    expect(find.text('\$3,657'), findsOneWidget);
    expect(find.text('E wallet'), findsOneWidget);
    expect(find.text('Online Shopping'), findsOneWidget);
  });
}
