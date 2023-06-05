import 'package:intl/intl.dart' as intl;

typedef NumberFormat = intl.NumberFormat;
typedef DigitOverride = ({int minDigit, int maxDigit});

final class NumberUtils {
  static String toDecimalString(num value,
      [DigitOverride? override, NumberFormat? format]) {
    if (override != null) {
      return _toFixedDecimalString(value, override, format);
    }
    return _toDynamicDecimalString(value, format);
  }

  static String _toDynamicDecimalString(num value, NumberFormat? format) =>
      switch (value) {
        < 0.1 =>
          _toFixedDecimalString(value, (minDigit: 0, maxDigit: 4), format),
        < 1 => _toFixedDecimalString(value, (minDigit: 0, maxDigit: 3), format),
        < 10 =>
          _toFixedDecimalString(value, (minDigit: 0, maxDigit: 2), format),
        < 100 =>
          _toFixedDecimalString(value, (minDigit: 0, maxDigit: 1), format),
        _ => _toFixedDecimalString(value, (minDigit: 0, maxDigit: 0), format)
      };
  static String _toFixedDecimalString(
      num value, DigitOverride override, intl.NumberFormat? format) {
    final formatter = format ?? intl.NumberFormat();
    final (:minDigit, :maxDigit) = override;
    formatter.minimumFractionDigits = minDigit;
    formatter.maximumFractionDigits = maxDigit;
    return formatter.format(value);
  }
}
