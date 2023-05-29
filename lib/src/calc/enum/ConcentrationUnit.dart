import 'package:freezed_annotation/freezed_annotation.dart';

import '../../exceptions.dart';

part 'ConcentrationUnit.freezed.dart';

const double DEFAULT_U = 1;
const mg = ConcentrationUnit.mg();
const mcg = ConcentrationUnit.mcg();
const nanogr = ConcentrationUnit.nanogr();
const U = ConcentrationUnit.U(DEFAULT_U);

@freezed
class ConcentrationUnit with _$ConcentrationUnit {
  const ConcentrationUnit._();
  const factory ConcentrationUnit.mg() = _mg;
  const factory ConcentrationUnit.mcg() = _mcg;
  const factory ConcentrationUnit.nanogr() = _nanogr;
  const factory ConcentrationUnit.U(double factorMG) = _U;

  factory ConcentrationUnit.fromJson(String json) {
    switch (json) {
      case "mg":
        return const ConcentrationUnit.mg();
      case "mcg":
        return const ConcentrationUnit.mcg();
      case "nanogr":
        return const ConcentrationUnit.nanogr();
      case "U":
        return const ConcentrationUnit.U(DEFAULT_U);
      default:
        throw const InvalidConcentrationUnitException();
    }
  }
  String toJSON() => name;
  double get factorMG => when(
      mg: () => 1,
      mcg: () => 0.001,
      nanogr: () => 0.000001,
      U: (factorMG) => factorMG);

  String get name {
    return toString().split('.')[1].split('(').first;
  }
}
