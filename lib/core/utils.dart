/// Application-wide utility functions.
library;

import 'package:intl/intl.dart';

/// Formats an integer [amount] as a dollar currency string with comma separators.
///
/// Example: `formatCurrency(3657)` → `'$3,657'`
String formatCurrency(int amount) {
  return NumberFormat.simpleCurrency(name: 'USD', decimalDigits: 0).format(amount);
}
