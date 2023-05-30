import '../../exceptions.dart';

sealed class ConcentrationUnit {
  static const double DEFAULT_U = 1;

  final String name;
  final double factorToMG;
  const ConcentrationUnit({required this.name, required this.factorToMG});

  factory ConcentrationUnit.fromJson(String json) => switch (json) {
        "mg" => mg,
        "mcg" => mcg,
        "nanogr" => nanoGr,
        "U" => U(factorToMG: DEFAULT_U),
        _ => throw InvalidConcentrationUnitException()
      };
  String toJSON() => name;

  @override
  String toString() => name;
}

const mg = MG._();

class MG extends ConcentrationUnit {
  const MG._() : super(name: "mg", factorToMG: 1);

  @override
  operator ==(Object other) => other is MG;

  @override
  int get hashCode => super.name.hashCode;
}

const mcg = MCG._();

class MCG extends ConcentrationUnit {
  const MCG._() : super(name: "mcg", factorToMG: 0.001);

  @override
  operator ==(Object other) => other is MCG;

  @override
  int get hashCode => super.name.hashCode;
}

const nanoGr = NanoGr._();

class NanoGr extends ConcentrationUnit {
  const NanoGr._() : super(name: "nanogr", factorToMG: 0.000001);

  @override
  operator ==(Object other) => other is NanoGr;

  @override
  int get hashCode => super.name.hashCode;
}

class U extends ConcentrationUnit {
  const U({required double factorToMG})
      : super(name: "U", factorToMG: factorToMG);
  @override
  operator ==(Object other) => other is U && other.factorToMG == factorToMG;

  @override
  int get hashCode => Object.hash(name, factorToMG);

  @override
  String toString() {
    return "U($factorToMG)";
  }
}
