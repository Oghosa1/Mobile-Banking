import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ViewModel managing the main bottom navigation tab index.
class NavigationViewModel extends AutoDisposeNotifier<int> {
  @override
  int build() {
    return 0; // Default index is Home/Dashboard (0)
  }

  /// Sets the active navigation tab index.
  void setIndex(int index) {
    state = index;
  }
}

/// Provider for the [NavigationViewModel] state.
final navigationViewModelProvider = NotifierProvider.autoDispose<NavigationViewModel, int>(() {
  return NavigationViewModel();
});
