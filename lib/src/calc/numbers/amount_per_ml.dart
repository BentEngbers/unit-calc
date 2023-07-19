import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/numbers/amount_per_time.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/numbers/volume_per_time.dart';
import 'package:unit_calc/src/calc/utils.dart';

import 'amount.dart';
import 'Volume.dart';

@immutable
class AmountPerML with EquatableMixin implements Number {
  final double value;
  final MassUnit unit;
  const AmountPerML(this.value, this.unit) : assert(value >= 0);

  //TODO: test this function
  Amount operator *(Volume volume) => Amount(volume.value * value, unit);

  //TODO: test this function
  AmountPerTime multiply(VolumePerTime volumePerTime) =>
      AmountPerTime(value * volumePerTime.value, unit, volumePerTime.timeUnit);

  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) {
    return "${NumberUtils.toDecimalString(value, override, format)} ${unit.name}/ml";
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
