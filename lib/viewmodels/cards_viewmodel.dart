import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Immutable state for the cards screen.
class CardsState extends Equatable {
  final String selectedCardType;
  final int currentCardIndex;
  final bool changePin;
  final bool qrPayment;
  final bool onlineShopping;
  final bool tapPay;

  const CardsState({
    required this.selectedCardType,
    required this.currentCardIndex,
    required this.changePin,
    required this.qrPayment,
    required this.onlineShopping,
    required this.tapPay,
  });

  CardsState copyWith({
    String? selectedCardType,
    int? currentCardIndex,
    bool? changePin,
    bool? qrPayment,
    bool? onlineShopping,
    bool? tapPay,
  }) {
    return CardsState(
      selectedCardType: selectedCardType ?? this.selectedCardType,
      currentCardIndex: currentCardIndex ?? this.currentCardIndex,
      changePin: changePin ?? this.changePin,
      qrPayment: qrPayment ?? this.qrPayment,
      onlineShopping: onlineShopping ?? this.onlineShopping,
      tapPay: tapPay ?? this.tapPay,
    );
  }

  @override
  List<Object?> get props => [
        selectedCardType,
        currentCardIndex,
        changePin,
        qrPayment,
        onlineShopping,
        tapPay,
      ];
}

/// ViewModel for managing card selection and settings state.
class CardsViewModel extends AutoDisposeNotifier<CardsState> {
  @override
  CardsState build() {
    return const CardsState(
      selectedCardType: 'Physical Card',
      currentCardIndex: 1,
      changePin: true,
      qrPayment: true,
      onlineShopping: false,
      tapPay: true,
    );
  }

  void setSelectedCardType(String cardType) {
    state = state.copyWith(selectedCardType: cardType);
  }

  void setCurrentCardIndex(int index) {
    state = state.copyWith(currentCardIndex: index);
  }

  void toggleChangePin(bool val) {
    state = state.copyWith(changePin: val);
  }

  void toggleQrPayment(bool val) {
    state = state.copyWith(qrPayment: val);
  }

  void toggleOnlineShopping(bool val) {
    state = state.copyWith(onlineShopping: val);
  }

  void toggleTapPay(bool val) {
    state = state.copyWith(tapPay: val);
  }
}

final cardsViewModelProvider = NotifierProvider.autoDispose<CardsViewModel, CardsState>(() {
  return CardsViewModel();
});
