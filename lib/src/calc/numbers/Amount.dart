import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/Calc.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/numbers/amount_per_ml.dart';
import 'package:unit_calc/src/calc/utils.dart';

import 'Number.dart';
import 'Volume.dart';

@immutable
class Amount with EquatableMixin implements Number {
  final double value;
  final MassUnit _unit;

  MassUnit get unit => _unit;
  const Amount(this.value, this._unit) : assert(value >= 0);

  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) =>
      '${NumberUtils.toDecimalString(value, override, format)} ${_unit.name}';

  @override
  String toString() => toDisplayString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Amount &&
          runtimeType == other.runtimeType &&
          Calc.doubleEquals(
              value * Calc.convertFactorOnlyUnit(from: unit, to: other.unit),
              other.value);

  //TODO:test this function
  bool operator >(Object other) =>
      other is Amount &&
      runtimeType == other.runtimeType &&
      (value * Calc.convertFactorOnlyUnit(from: unit, to: other.unit)) >
          other.value;
  //TODO: test this function
  bool operator >=(Object other) => this == other || this > other;

  @override
  int get hashCode => Object.hash(value, _unit);

  AmountPerML divide(Volume volume) => AmountPerML(value / volume.value, unit);

  convertTo(MassUnit toUnit) => Amount(
      value * Calc.convertFactorOnlyUnit(from: unit, to: toUnit), toUnit);
  Volume operator /(AmountPerML concentration) {
    Amount convertedAmount = convertTo(concentration.unit);
    return Volume(convertedAmount.value / concentration.value);
  }

  @override
  List<Object?> get props => [
        value,
        unit,
      ];
  @override
  bool? get stringify => false;
}
