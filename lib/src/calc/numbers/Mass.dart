import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/Calc.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_volume.dart';
import 'package:unit_calc/src/calc/utils.dart';

import 'Number.dart';
import 'Volume.dart';

@immutable
class Mass implements Number {
  final num value;
  final MassUnit unit;

  const Mass(this.value, this.unit) : assert(value >= 0);
  const Mass.kiloGram(this.value)
      : unit = kiloGram,
        assert(value >= 0);

  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) =>
      '${NumberUtils.toDecimalString(value, override, format)} ${unit.displayName}';

  @override
  String toString() => toDisplayString();

  MassPerVolume divide(Volume volume) =>
      MassPerVolume(value / volume.asNumber(volume.unit), unit, volume.unit);

  Mass as(MassUnit? toUnit) => Mass(
      value * Calc.convertFactorOnlyUnit(from: unit, to: toUnit ?? unit),
      toUnit ?? unit);

  num asNumber(MassUnit? unit) => as(unit).value;

  Volume operator /(MassPerVolume concentration) => Volume(
      asNumber(concentration.massUnit) / concentration.asNumber(),
      concentration.volumeUnit);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Mass &&
          runtimeType == other.runtimeType &&
          asNumber(other.unit) == other.asNumber(other.unit);

  bool operator >(Object other) =>
      identical(this, other) ||
      other is Mass &&
          runtimeType == other.runtimeType &&
          asNumber(other.unit) > other.asNumber(other.unit);

  bool operator >=(Object other) =>
      identical(this, other) ||
      other is Mass &&
          runtimeType == other.runtimeType &&
          asNumber(other.unit) >= other.asNumber(other.unit);

  @override
  int get hashCode => Object.hash(value, unit);
}
