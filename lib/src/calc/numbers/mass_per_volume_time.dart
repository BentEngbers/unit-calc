import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/time_unit.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';

@immutable
class AmountPerMLTime with EquatableMixin implements Number {
  final double value;
  final MassUnit unit;
  final TimeUnit timeUnit;
  const AmountPerMLTime(this.value, this.unit, this.timeUnit)
      : assert(value > 0);

  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) {
    return "${NumberUtils.toDecimalString(value, override, format)} ${unit.name}/ml/${timeUnit.name}";
  }

  @override
  String toString() => toDisplayString();

  @override
  List<Object?> get props => [
        value,
        unit,
        timeUnit,
      ];
  @override
  bool? get stringify => false;
}
