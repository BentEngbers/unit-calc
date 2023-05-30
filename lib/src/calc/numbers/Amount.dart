import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/Calc.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/numbers/amount_per_ml.dart';

import 'Number.dart';
import 'Volume.dart';

@immutable
abstract class AbstractAmount extends Number {
  final ConcentrationUnit _unit;

  //@JsonKey(includeFromJson: false, includeToJson: false)
  ConcentrationUnit get unit => _unit;
  AbstractAmount(double value, this._unit) : super(value);

  String _todisplayString(String number) => '$number ${_unit.name}';

  @override
  String toFixedDecimalString({int minDigit = 1, int maxDigit = 1}) =>
      _todisplayString(
          super.toFixedDecimalString(minDigit: minDigit, maxDigit: maxDigit));

  @override
  String toString() => super.toDynamicDecimalString;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AbstractAmount &&
          runtimeType == other.runtimeType &&
          Calc.doubleEquals(
              value * Calc.convertFactorOnlyUnit(from: unit, to: other.unit),
              other.value);

  //TODO:test this function
  bool operator >(Object other) =>
      other is AbstractAmount &&
      runtimeType == other.runtimeType &&
      (value * Calc.convertFactorOnlyUnit(from: unit, to: other.unit)) >
          other.value;
  //TODO: test this function
  bool operator >=(Object other) => this == other || this > other;

  @override
  int get hashCode => _unit.hashCode ^ super.hashCode;
}

///DO NOT EXTEND: EXTEND [AbstractAmount] INSTEAD.
@immutable
class Amount extends AbstractAmount {
  Amount(double value, ConcentrationUnit unit) : super(value, unit);
  convertTo(ConcentrationUnit toUnit) => Amount(
      value * Calc.convertFactorOnlyUnit(from: unit, to: toUnit), toUnit);
  Volume operator /(AmountPerML concentration) {
    Amount convertedAmount = convertTo(concentration.unit);
    return Volume(convertedAmount.value / concentration.value);
  }

  //TODO: test this function
  AmountPerML divide(Volume volume) => AmountPerML(value / volume.value, unit);
}
