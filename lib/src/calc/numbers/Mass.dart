import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/Calc.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_volume.dart';
import 'package:unit_calc/src/calc/utils.dart';

import 'Number.dart';
import 'Volume.dart';

@immutable
class Mass with EquatableMixin implements Number {
  final num value;
  final MassUnit unit;

  const Mass(this.value, this.unit) : assert(value >= 0);
  const Mass.kiloGram(this.value)
      : unit = kiloGram,
        assert(value >= 0);

  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) =>
      '${NumberUtils.toDecimalString(value, override, format)} ${unit.name}';

  @override
  String toString() => toDisplayString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Mass &&
          runtimeType == other.runtimeType &&
          Calc.doubleEquals(
              value * Calc.convertFactorOnlyUnit(from: unit, to: other.unit),
              other.value);

  //TODO:test this function
  bool operator >(Object other) =>
      other is Mass &&
      runtimeType == other.runtimeType &&
      (value * Calc.convertFactorOnlyUnit(from: unit, to: other.unit)) >
          other.value;
  //TODO: test this function
  bool operator >=(Object other) => this == other || this > other;

  @override
  int get hashCode => Object.hash(value, unit);

  MassPerVolume divide(Volume volume) =>
      MassPerVolume(value / volume.asNumber(volume.unit), unit, volume.unit);

  Mass as(MassUnit toUnit) =>
      Mass(value * Calc.convertFactorOnlyUnit(from: unit, to: toUnit), toUnit);
  num asNumber(MassUnit unit) => as(unit).value;
  Volume operator /(MassPerVolume concentration) => Volume(
      asNumber(concentration.unit) / concentration.value,
      concentration.volumeUnit);

  @override
  List<Object?> get props => [
        value,
        unit,
      ];
  @override
  bool? get stringify => false;
}
