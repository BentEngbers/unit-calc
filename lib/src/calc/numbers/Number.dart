import 'package:meta/meta.dart';

import '../Calc.dart';
import 'package:intl/intl.dart' as intl;

@immutable
abstract class Number {
  final double _value;
  double get value => _value;

  const Number(this._value) : assert(_value >= 0);
  // {
  //   if (_value.isNegative) {
  //     throw NegativeNumberException(
  //         "The value of the volume cannot be negative (value given: '$_value')");
  //   }
  // }
  bool get isAbsoluteZero => value == 0;

  /// Check if the number is close to zero within a certain [threshold].
  bool get isZero => Calc.doubleEquals(value, 0);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Number &&
          runtimeType == other.runtimeType &&
          Calc.doubleEquals(value, other.value);

  @override
  int get hashCode => _value.hashCode;

  /// This method sets the min and max digits depending on the value.
  @override
  String toString() => toDynamicDecimalString;

  String get toDynamicDecimalString {
    if (value < 0.1) {
      return toFixedDecimalString(minDigit: 0, maxDigit: 4);
    }
    if (value < 1) {
      return toFixedDecimalString(minDigit: 0, maxDigit: 3);
    }
    if (value < 10) {
      return toFixedDecimalString(minDigit: 0, maxDigit: 2);
    }
    if (value < 100) {
      return toFixedDecimalString(minDigit: 0, maxDigit: 1);
    }
    return toFixedDecimalString(minDigit: 0, maxDigit: 0);
  }

  @protected
  String toFixedDecimalString({int minDigit = 0, int maxDigit = 1}) {
    intl.NumberFormat formatter = intl.NumberFormat();
    formatter.minimumFractionDigits = minDigit;
    formatter.maximumFractionDigits = maxDigit;
    return formatter.format(_value);
  }
}
