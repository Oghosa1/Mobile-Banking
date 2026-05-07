import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/card_model.dart';
import '../models/transaction_model.dart';
import '../services/mock_data_service.dart';

final mockDataServiceProvider = Provider<MockDataService>((ref) {
  return MockDataService();
});

final userNameStreamProvider = StreamProvider.autoDispose<String>((ref) {
  final service = ref.watch(mockDataServiceProvider);
  return service.userNameStream;
});

final balanceStreamProvider = StreamProvider.autoDispose<double>((ref) {
  final service = ref.watch(mockDataServiceProvider);
  return service.balanceStream;
});

final transactionStreamProvider = StreamProvider.autoDispose<List<TransactionModel>>((ref) {
  final service = ref.watch(mockDataServiceProvider);
  return service.transactionStream;
});

final cardsStreamProvider = StreamProvider.autoDispose<List<CardModel>>((ref) {
  final service = ref.watch(mockDataServiceProvider);
  return service.cardsStream;
});
