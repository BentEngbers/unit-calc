import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/utils.dart';

@immutable
abstract interface class Number {
  @override
  @mustBeOverridden
  String toString();
  // bool get isZero => value == 0;
  @override
  @mustBeOverridden
  bool operator ==(Object other);
  // /// Check if the number is close to zero within a certain [threshold].
  // bool get isCloseToZero => Calc.doubleEquals(value, 0);
  @mustBeOverridden
  String toJson();
  @mustBeOverridden
  String toDisplayString([DigitPrecision? override, NumberFormat? format]);

  @override
  @mustBeOverridden
  int get hashCode => super.hashCode;
}
