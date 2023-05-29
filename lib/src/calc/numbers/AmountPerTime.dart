import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/ConcentrationUnit.dart';
import 'package:unit_calc/src/calc/enum/TimeUnit.dart';
import 'package:unit_calc/src/calc/numbers/Amount.dart';
import 'package:unit_calc/src/calc/numbers/AmountPerKGTime.dart';
import 'package:unit_calc/src/calc/numbers/AmountPerML.dart';
import 'package:unit_calc/src/calc/numbers/Mass.dart';
import 'package:unit_calc/src/calc/numbers/VolumePerTime.dart';

import '../Calc.dart';

@immutable
abstract class AbstractAmountPerTime extends AbstractAmount {
  final TimeUnit _timeUnit;
  TimeUnit get timeUnit => _timeUnit;
  AbstractAmountPerTime(double value, ConcentrationUnit unit, this._timeUnit)
      : super(value, unit);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AbstractAmountPerTime &&
          runtimeType == other.runtimeType &&
          Calc.doubleEquals(
              value *
                  Calc.convertFactor(
                      from: unit,
                      to: other.unit,
                      fromTime: timeUnit,
                      toTime: other.timeUnit),
              other.value);

  @override
  int get hashCode => _timeUnit.hashCode ^ super.hashCode;
}

@sealed
@immutable
class AmountPerTime extends AbstractAmountPerTime {
  AmountPerTime(double value, ConcentrationUnit unit, TimeUnit timeUnit)
      : super(value, unit, timeUnit);

  String _todisplayString(String number) => "$number/${timeUnit.name}";

  @override
  String toFixedDecimalString({int minDigit = 1, int maxDigit = 1}) =>
      _todisplayString(
          super.toFixedDecimalString(minDigit: minDigit, maxDigit: maxDigit));

  @override
  String toString() => super.toDynamicDecimalString;

  VolumePerTime operator /(AmountPerML volume) {
    final double convertedValue =
        value * Calc.convertFactorOnlyUnit(from: unit, to: volume.unit);
    return VolumePerTime(convertedValue / volume.value, _timeUnit);
  }

  //TODO: test this function div
  AmountPerKGTime divide(Mass patientWeight) =>
      AmountPerKGTime(value / patientWeight.value, unit, timeUnit);
}
