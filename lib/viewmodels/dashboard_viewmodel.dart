import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ViewModel for the dashboard screen that manages the transaction filter state.
class DashboardViewModel extends AutoDisposeNotifier<String> {
  @override
  String build() {
    return 'Today';
  }

  void setFilter(String filter) {
    state = filter;
  }
}

final dashboardViewModelProvider = NotifierProvider.autoDispose<DashboardViewModel, String>(() {
  return DashboardViewModel();
});
