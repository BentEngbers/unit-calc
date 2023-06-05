import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/utils.dart';

import 'Number.dart';

@immutable
final class Volume with EquatableMixin implements Number {
  static const String _unit = 'ml';
  final double value;
  const Volume(this.value) : assert(value >= 0);

  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) =>
      "${NumberUtils.toDecimalString(value, override, format)} $_unit";

  @override
  String toString() => toDisplayString();

  Volume operator +(Volume volume) => Volume(value + volume.value);
  Volume operator -(Volume volume) => Volume(value - volume.value);
  static Volume fromJson(double value) => Volume(value);
  static double toJSON(Volume volume) => volume.value;

  @override
  List<Object?> get props => [
        value,
      ];
  @override
  bool? get stringify => false;
}
