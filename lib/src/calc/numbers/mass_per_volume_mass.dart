import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_volume.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';

@immutable
class AmountPerVolumeMass with EquatableMixin implements Number {
  final double value;
  final MassUnit unit;
  final VolumeUnit volumeUnit;
  const AmountPerVolumeMass(this.value, this.unit, this.volumeUnit)
      : assert(value >= 0);

  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) {
    return "${NumberUtils.toDecimalString(value, override, format)} ${unit.name}/$volumeUnit/kg";
  }

  @override
  String toString() => toDisplayString();

  MassPerVolume operator *(Mass mass) =>
      MassPerVolume(value * mass.value, unit, volumeUnit);

  @override
  List<Object?> get props => [
        value,
        unit,
      ];
  @override
  bool? get stringify => false;
}
