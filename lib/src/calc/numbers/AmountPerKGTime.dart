import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/Calc.dart';
import 'package:unit_calc/src/calc/enum/ConcentrationUnit.dart';
import 'package:unit_calc/src/calc/enum/TimeUnit.dart';
import 'package:unit_calc/src/calc/numbers/AmountPerTime.dart';

import 'Mass.dart';

@immutable
class AmountPerKGTime extends AbstractAmountPerTime {
  AmountPerKGTime(double value, ConcentrationUnit unit, TimeUnit timeUnit)
      : super(value, unit, timeUnit);

  String _todisplayString(String number) => "$number/kg/${timeUnit.name}";

  @override
  String toFixedDecimalString({int minDigit = 1, int maxDigit = 1}) =>
      _todisplayString(
          super.toFixedDecimalString(minDigit: minDigit, maxDigit: maxDigit));

  @override
  String toString() => super.toDynamicDecimalString;

  //TODO: test this function
  AmountPerTime operator *(Mass mass) =>
      AmountPerTime(mass.value * value, unit, timeUnit);

  //TODO: test this function
  AmountPerKGTime convertToTime(ConcentrationUnit toUnit, TimeUnit toTime) =>
      AmountPerKGTime(
          value *
              Calc.convertFactor(
                  from: unit, to: toUnit, fromTime: timeUnit, toTime: toTime),
          toUnit,
          toTime);
}
