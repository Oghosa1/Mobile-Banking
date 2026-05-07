import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fintech_ui/viewmodels/navigation_viewmodel.dart';

void main() {
  test('NavigationViewModel initial state is 0', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(navigationViewModelProvider), 0);
  });

  test('NavigationViewModel setIndex updates state correctly', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(navigationViewModelProvider.notifier).setIndex(2);
    expect(container.read(navigationViewModelProvider), 2);
  });
}
