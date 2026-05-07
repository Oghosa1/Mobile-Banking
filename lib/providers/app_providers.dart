import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/card_model.dart';
import '../models/transaction_model.dart';
import '../services/mock_data_service.dart';

/// Provider for the mock data service singleton.
final mockDataServiceProvider = Provider<MockDataService>((ref) {
  return MockDataService();
});

/// Provides a stream of the current user's display name.
final userNameStreamProvider = StreamProvider.autoDispose<String>((ref) {
  final service = ref.watch(mockDataServiceProvider);
  return service.userNameStream;
});

/// Provides a stream of the user's account balance.
final balanceStreamProvider = StreamProvider.autoDispose<double>((ref) {
  final service = ref.watch(mockDataServiceProvider);
  return service.balanceStream;
});

/// Provides a stream of the user's transaction history.
final transactionStreamProvider = StreamProvider.autoDispose<List<TransactionModel>>((ref) {
  final service = ref.watch(mockDataServiceProvider);
  return service.transactionStream;
});

/// Provides a stream of the user's payment cards.
final cardsStreamProvider = StreamProvider.autoDispose<List<CardModel>>((ref) {
  final service = ref.watch(mockDataServiceProvider);
  return service.cardsStream;
});
