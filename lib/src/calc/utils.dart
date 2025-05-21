import 'package:intl/intl.dart' as intl;

typedef NumberFormat = intl.NumberFormat;
typedef DigitPrecision = ({int minDigit, int maxDigit});

final class NumberUtils {
  static String toDecimalString(
    num value, [
    DigitPrecision? override,
    NumberFormat? format,
  ]) {
    if (override != null) {
      return _toFixedDecimalString(value, override, format);
    }
    return _toDynamicDecimalString(value, format);
  }

  static String _toDynamicDecimalString(
    num value,
    NumberFormat? format,
  ) => switch (value) {
    < 0.1 => _toFixedDecimalString(value, (minDigit: 0, maxDigit: 4), format),
    < 1 => _toFixedDecimalString(value, (minDigit: 0, maxDigit: 3), format),
    < 10 => _toFixedDecimalString(value, (minDigit: 0, maxDigit: 2), format),
    < 100 => _toFixedDecimalString(value, (minDigit: 0, maxDigit: 1), format),
    _ => _toFixedDecimalString(value, (minDigit: 0, maxDigit: 0), format),
  };
  static String _toFixedDecimalString(
    num value,
    DigitPrecision override,
    intl.NumberFormat? format,
  ) {
    final formatter = format ?? intl.NumberFormat();
    formatter.currencyName;
    formatter.minimumFractionDigits = override.minDigit;
    formatter.maximumFractionDigits = override.maxDigit;
    return formatter.format(value);
  }
}

typedef ParseTuple = (String, List<String>);

final class ParseUtilities {
  static ParseTuple splitString(String json) {
    if (!json.contains(" ")) {
      throw const FormatException("Could not match on the required ' '");
    }
    final [numberPart, ...r] = json.split(" ");
    return (numberPart, r.join(" ").split("/"));
  }
}
