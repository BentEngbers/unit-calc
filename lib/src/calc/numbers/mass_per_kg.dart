import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';

@immutable
class AmountPerKG with EquatableMixin implements Number {
  final double value;
  final MassUnit unit;
  const AmountPerKG(this.value, this.unit) : assert(value > 0);
  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) =>
      "${NumberUtils.toDecimalString(value, override, format)} ${unit.name}/kg";
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
