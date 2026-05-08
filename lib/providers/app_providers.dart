import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fintech_ui/core/config/environment_providers.dart';
import '../models/card_model.dart';
import '../models/transaction_model.dart';
import '../services/mock_data_service.dart';

/// Provider for the mock data service singleton.
final mockDataServiceProvider = Provider<MockDataService>((ref) {
  return MockDataService();
});

/// Provides a stream of the current user's display name, respecting environment mock settings.
final userNameStreamProvider = StreamProvider.autoDispose<String>((ref) async* {
  final env = ref.watch(environmentProvider);
  final mockService = ref.watch(mockDataServiceProvider);

  if (env.enableMock) {
    yield* mockService.userNameStream;
    return;
  }

  try {
    final dio = ref.watch(dioProvider);
    final response = await dio.get('/user');
    if (response.data != null && response.data['name'] != null) {
      yield response.data['name'] as String;
      return;
    }
  } catch (_) {
    // Network failed or endpoint is not real, gracefully fall back to mock data
  }

  yield* mockService.userNameStream;
});

/// Provides a stream of the user's account balance, respecting environment mock settings.
final balanceStreamProvider = StreamProvider.autoDispose<double>((ref) async* {
  final env = ref.watch(environmentProvider);
  final mockService = ref.watch(mockDataServiceProvider);

  if (env.enableMock) {
    yield* mockService.balanceStream;
    return;
  }

  try {
    final dio = ref.watch(dioProvider);
    final response = await dio.get('/balance');
    if (response.data != null && response.data['balance'] != null) {
      yield (response.data['balance'] as num).toDouble();
      return;
    }
  } catch (_) {
    // Network failed or endpoint is not real, gracefully fall back to mock data
  }

  yield* mockService.balanceStream;
});

/// Provides a stream of the user's transaction history, respecting environment mock settings.
final transactionStreamProvider = StreamProvider.autoDispose<List<TransactionModel>>((ref) async* {
  final env = ref.watch(environmentProvider);
  final mockService = ref.watch(mockDataServiceProvider);

  if (env.enableMock) {
    yield* mockService.transactionStream;
    return;
  }

  try {
    final dio = ref.watch(dioProvider);
    final response = await dio.get('/transactions');
    if (response.data != null && response.data is List) {
      final list = (response.data as List)
          .map((item) => TransactionModel.fromJson(item as Map<String, dynamic>))
          .toList();
      yield list;
      return;
    }
  } catch (_) {
    // Network failed or endpoint is not real, gracefully fall back to mock data
  }

  yield* mockService.transactionStream;
});

/// Provides a stream of the user's payment cards, respecting environment mock settings.
final cardsStreamProvider = StreamProvider.autoDispose<List<CardModel>>((ref) async* {
  final env = ref.watch(environmentProvider);
  final mockService = ref.watch(mockDataServiceProvider);

  if (env.enableMock) {
    yield* mockService.cardsStream;
    return;
  }

  try {
    final dio = ref.watch(dioProvider);
    final response = await dio.get('/cards');
    if (response.data != null && response.data is List) {
      final list = (response.data as List)
          .map((item) => CardModel.fromJson(item as Map<String, dynamic>))
          .toList();
      yield list;
      return;
    }
  } catch (_) {
    // Network failed or endpoint is not real, gracefully fall back to mock data
  }

  yield* mockService.cardsStream;
});
