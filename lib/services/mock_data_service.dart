import '../models/card_model.dart';
import '../models/transaction_model.dart';

class MockDataService {
  static const String _userName = 'Tayyab Sohail';
  static const double _balance = 1200.0;

  static const List<TransactionModel> _transactions = [
    TransactionModel(
      id: 't_1',
      title: 'E wallet',
      subtitle: 'Mar 7 2024 at 09:44 pm',
      amount: '120\$',
      isCredit: true,
      time: 'Today',
    ),
    TransactionModel(
      id: 't_2',
      title: 'Online Shopping',
      subtitle: 'Feb 12 2024 at 10:24 pm',
      amount: '80\$',
      isCredit: false,
      time: 'Today',
    ),
    TransactionModel(
      id: 't_3',
      title: 'Banking Fee',
      subtitle: 'Feb 1 2024 at 01:30 am',
      amount: '10\$',
      isCredit: false,
      time: 'Weekly',
    ),
    TransactionModel(
      id: 't_4',
      title: 'Saving',
      subtitle: 'Jan 27 2024 at 10:47 am',
      amount: '200\$',
      isCredit: true,
      time: 'Monthly',
    ),
  ];

  static const List<CardModel> _cards = [
    CardModel(
      id: 'card_1',
      number: '•••• •••• •••• 1124',
      holder: 'Tayyab Sohail',
      valid: '04 / 09 / 2027',
      cvv: '342',
      cardType: 'Physical Card',
    ),
    CardModel(
      id: 'card_2',
      number: '•••• •••• •••• 3466',
      holder: 'Tayyab Sohail',
      valid: '12 / 02 / 2024',
      cvv: '663',
      cardType: 'Physical Card',
    ),
    CardModel(
      id: 'card_3',
      number: '•••• •••• •••• 8851',
      holder: 'Tayyab Sohail',
      valid: '08 / 11 / 2029',
      cvv: '904',
      cardType: 'Virtual Card',
    ),
  ];

  /// Emits the mock user name.
  Stream<String> get userNameStream => Stream.value(_userName);

  /// Emits the mock wallet balance.
  Stream<double> get balanceStream => Stream.value(_balance);

  /// Emits the list of mock transactions.
  Stream<List<TransactionModel>> get transactionStream => Stream.value(_transactions);

  /// Emits the list of mock cards.
  Stream<List<CardModel>> get cardsStream => Stream.value(_cards);
}
