import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass.dart';
import 'package:unit_calc/src/calc/numbers/amount_per_ml.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';

@immutable
class AmountPerMLKG with EquatableMixin implements Number {
  final double value;
  final MassUnit unit;
  const AmountPerMLKG(this.value, this.unit) : assert(value >= 0);
  String _todisplayString(String number) => "$number/ml/kg";

  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) {
    return "${NumberUtils.toDecimalString(value, override, format)} ${unit.name}/ml/kg";
  }

  @override
  String toString() => toDisplayString();

  AmountPerML operator *(Mass mass) => AmountPerML(value * mass.value, unit);

  @override
  List<Object?> get props => [
        value,
        unit,
      ];
  @override
  bool? get stringify => false;
}
