import 'package:equatable/equatable.dart';

class CardModel extends Equatable {
  final String id;
  final String number;
  final String holder;
  final String valid;
  final String cvv;
  final String cardType; // 'Physical Card' or 'Virtual Card'

  const CardModel({
    required this.id,
    required this.number,
    required this.holder,
    required this.valid,
    required this.cvv,
    required this.cardType,
  });

  CardModel copyWith({
    String? id,
    String? number,
    String? holder,
    String? valid,
    String? cvv,
    String? cardType,
  }) {
    return CardModel(
      id: id ?? this.id,
      number: number ?? this.number,
      holder: holder ?? this.holder,
      valid: valid ?? this.valid,
      cvv: cvv ?? this.cvv,
      cardType: cardType ?? this.cardType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'holder': holder,
      'valid': valid,
      'cvv': cvv,
      'cardType': cardType,
    };
  }

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] as String,
      number: json['number'] as String,
      holder: json['holder'] as String,
      valid: json['valid'] as String,
      cvv: json['cvv'] as String,
      cardType: json['cardType'] as String,
    );
  }

  @override
  List<Object?> get props => [id, number, holder, valid, cvv, cardType];
}
