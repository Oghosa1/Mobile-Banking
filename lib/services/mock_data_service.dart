import '../models/card_model.dart';
import '../models/transaction_model.dart';

class MockDataService {
  Stream<String> get userNameStream {
    return Stream.value('Tayyab Sohail').asBroadcastStream();
  }

  Stream<double> get balanceStream {
    return Stream.periodic(
      const Duration(seconds: 8),
      (count) => 1200.0 + (count * 15.0),
    ).asBroadcastStream();
  }

  Stream<List<TransactionModel>> get transactionStream {
    return Stream.periodic(
      const Duration(seconds: 12),
      (count) {
        final List<TransactionModel> list = [
          const TransactionModel(
            id: 't_1',
            title: 'E wallet',
            subtitle: 'Feb 12 2024 at 10:24 pm',
            amount: '120\$',
            isCredit: true,
            time: 'Today',
          ),
          const TransactionModel(
            id: 't_2',
            title: 'Online Shopping',
            subtitle: 'Feb 12 2024 at 10:24 pm',
            amount: '80\$',
            isCredit: false,
            time: 'Today',
          ),
          const TransactionModel(
            id: 't_3',
            title: 'Banking Fee',
            subtitle: 'Feb 12 2024 at 10:24 pm',
            amount: '10\$',
            isCredit: false,
            time: 'Weekly',
          ),
          const TransactionModel(
            id: 't_4',
            title: 'Saving',
            subtitle: 'Feb 12 2024 at 10:24 pm',
            amount: '200\$',
            isCredit: true,
            time: 'Monthly',
          ),
        ];
        if (count > 0) {
          list.insert(
            0,
            TransactionModel(
              id: 't_new_$count',
              title: 'Bonus Reward',
              subtitle: 'Just now',
              amount: '${count * 5}\$',
              isCredit: true,
              time: 'Today',
            ),
          );
        }
        return list;
      },
    ).asBroadcastStream();
  }

  Stream<List<CardModel>> get cardsStream {
    return Stream.value([
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
      const CardModel(
        id: 'card_3',
        number: '•••• •••• •••• 8851',
        holder: 'Tayyab Sohail',
        valid: '08 / 11 / 2029',
        cvv: '904',
        cardType: 'Virtual Card',
      ),
    ]).asBroadcastStream();
  }
}
