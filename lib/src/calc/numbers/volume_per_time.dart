//TODO: test this class

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/Calc.dart';
import 'package:unit_calc/src/calc/enum/time_unit.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';

@immutable
class VolumePerTime with EquatableMixin implements Number {
  final double value;
  final TimeUnit timeUnit;
  const VolumePerTime(this.value, this.timeUnit) : assert(value >= 0);
  String get _unit => 'ml/${timeUnit.name}';

  @override
  String toString() => toDisplayString();

  //TODO: test function
  VolumePerTime toTimeUnit(TimeUnit toTime) => VolumePerTime(
      value * Calc.convertFactorOnlyTime(fromTime: timeUnit, toTime: toTime),
      toTime);

  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) {
    return "${NumberUtils.toDecimalString(value, override, format)} $_unit";
  }

  @override
  List<Object?> get props => [
        value,
        timeUnit,
      ];
  @override
  bool? get stringify => false;
}
