import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ViewModel managing user profile preferences and settings (e.g., notifications).
class ProfileViewModel extends AutoDisposeNotifier<bool> {
  @override
  bool build() {
    return true; // default notification state is true
  }

  /// Updates the notification preference state.
  void setNotificationsEnabled(bool enabled) {
    state = enabled;
  }
}

/// Provider for the [ProfileViewModel] state.
final profileViewModelProvider = NotifierProvider.autoDispose<ProfileViewModel, bool>(() {
  return ProfileViewModel();
});
