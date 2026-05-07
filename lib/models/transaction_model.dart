import 'package:equatable/equatable.dart';

/// An immutable data model representing a financial transaction.
class TransactionModel extends Equatable {
  /// Unique identifier of the transaction.
  final String id;

  /// Primary title or recipient of the transaction.
  final String title;

  /// Secondary description or category of the transaction.
  final String subtitle;

  /// Rounded string representation of the transaction amount.
  final String amount;

  /// Indication of whether the transaction adds to the balance (credit)
  /// or deducts from it (debit).
  final bool isCredit;

  /// Categorical time stamp or interval (e.g. Weekly, Monthly, Today).
  final String time;

  /// Creates a constant [TransactionModel] instance.
  const TransactionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isCredit,
    required this.time,
  });

  /// Creates a copy of this [TransactionModel] with custom fields overridden.
  TransactionModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? amount,
    bool? isCredit,
    String? time,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      amount: amount ?? this.amount,
      isCredit: isCredit ?? this.isCredit,
      time: time ?? this.time,
    );
  }

  /// Converts this model instance into a JSON-compatible map representation.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'amount': amount,
      'isCredit': isCredit,
      'time': time,
    };
  }

  /// Reconstructs a [TransactionModel] instance from a strongly-typed JSON map.
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      amount: json['amount'] as String,
      isCredit: json['isCredit'] as bool,
      time: json['time'] as String,
    );
  }

  @override
  List<Object?> get props => [id, title, subtitle, amount, isCredit, time];
}
