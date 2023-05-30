import 'package:meta/meta.dart';
import 'Number.dart';

@immutable
class Mass extends Number {
  Mass(double value) : super(value);

  String _todisplayString(String number) => '$number kg';

  @override
  String toFixedDecimalString({int minDigit = 1, int maxDigit = 1}) =>
      _todisplayString(
          super.toFixedDecimalString(minDigit: minDigit, maxDigit: maxDigit));

  @override
  String toString() => super.toDynamicDecimalString;

  bool operator <(Mass other) => value < other.value;

  bool operator <=(Mass other) => value <= other.value;

  static Mass fromJson(double value) => Mass(value);
  static double toJSON(Mass mass) => mass.value;
}
