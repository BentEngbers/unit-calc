import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_time.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/numbers/volume_per_time.dart';
import 'package:unit_calc/src/calc/utils.dart';

import 'mass.dart';
import 'Volume.dart';

@immutable
class MassPerVolume with EquatableMixin implements Number {
  final double value;
  final MassUnit unit;
  final VolumeUnit volumeUnit;
  const MassPerVolume(this.value, this.unit, this.volumeUnit)
      : assert(value >= 0);

  //TODO: test this function
  Mass operator *(Volume volume) =>
      Mass(volume.asNumber(volume.unit) * value, unit);

  //TODO: test this function
  MassPerTime multiply(VolumePerTime volumePerTime) =>
      MassPerTime(value * volumePerTime.value, unit, volumePerTime.timeUnit);

  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) {
    return "${NumberUtils.toDecimalString(value, override, format)} ${unit.name}/$volumeUnit";
  }

  @override
  String toString() => toDisplayString();

  @override
  List<Object?> get props => [
        value,
        unit,
      ];
  @override
  bool? get stringify => false;
}
