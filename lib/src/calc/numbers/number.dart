import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/utils.dart';

@immutable
@JsonSerializable(explicitToJson: true)
abstract interface class Number {
  @override
  String toString();
  // bool get isZero => value == 0;

  // /// Check if the number is close to zero within a certain [threshold].
  // bool get isCloseToZero => Calc.doubleEquals(value, 0);
  String toJson();
  String toDisplayString([DigitPrecision? override, NumberFormat? format]);
}
