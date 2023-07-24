import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/Calc.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/utils.dart';

import 'Number.dart';

@immutable
final class Volume with EquatableMixin implements Number {
  final VolumeUnit unit;

  final num _value;
  const Volume(this._value, this.unit) : assert(_value >= 0);
  const Volume.ml(this._value)
      : unit = VolumeUnit.ml,
        assert(_value >= 0);

  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) =>
      "${NumberUtils.toDecimalString(_value, override, format)} $unit";

  @override
  String toString() => toDisplayString();

  Volume operator +(Volume volume) =>
      Volume(_value + volume.asNumber(unit), unit);
  Volume operator -(Volume volume) =>
      Volume(_value - volume.asNumber(unit), unit);
  Volume as(VolumeUnit unit) => Volume(
      _value * Calc.convertFactorOnlyVolume(from: this.unit, to: unit), unit);
  num asNumber(VolumeUnit unit) => as(unit)._value;
  //static Volume fromJson(double value) => Volume(value);
  //static double toJSON(Volume volume) => volume.value;

  @override
  List<Object?> get props => [
        _value,
      ];
  @override
  bool? get stringify => false;
}
