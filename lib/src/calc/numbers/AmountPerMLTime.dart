import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/ConcentrationUnit.dart';
import 'package:unit_calc/src/calc/enum/TimeUnit.dart';
import 'package:unit_calc/src/calc/numbers/AmountPerTime.dart';

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
