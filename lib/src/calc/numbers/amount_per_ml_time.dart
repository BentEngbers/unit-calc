import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/time_unit.dart';
import 'package:unit_calc/src/calc/numbers/amount_per_time.dart';

@immutable
class AmountPerMLTime extends AbstractAmountPerTime {
  AmountPerMLTime(double value, ConcentrationUnit unit, TimeUnit timeUnit)
      : super(value, unit, timeUnit);

  String _todisplayString(String number) => "$number/ml/${timeUnit.name}";

  @override
  String toFixedDecimalString({int minDigit = 1, int maxDigit = 1}) =>
      _todisplayString(
          super.toFixedDecimalString(minDigit: minDigit, maxDigit: maxDigit));

  @override
  String toString() => super.toDynamicDecimalString;
}
