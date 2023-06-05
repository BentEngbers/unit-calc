import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/utils.dart';
import 'Number.dart';

@immutable
final class Mass with EquatableMixin implements Number {
  final double value;
  const Mass(this.value) : assert(value >= 0);

  String get _unit => 'kg';

  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) =>
      "${NumberUtils.toDecimalString(value, override, format)} $_unit";

  @override
  String toString() => toDisplayString();

  bool operator <(Mass other) => value < other.value;

  bool operator <=(Mass other) => value <= other.value;

  static Mass fromJson(double value) => Mass(value);
  static double toJSON(Mass mass) => mass.value;

  @override
  List<Object?> get props => [value];
  @override
  bool? get stringify => false;
}
