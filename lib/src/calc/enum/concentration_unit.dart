import '../../exceptions.dart';

sealed class MassUnit {
  static const double defaultUFactorToMG = 1;

  final String name;
  final double factorToMG;
  const MassUnit({required this.name, required this.factorToMG});

  factory MassUnit.fromJson(String json) => switch (json) {
        "mg" => mg,
        "mcg" => mcg,
        "nanogr" => nanoGr,
        "U" => U(factorToMG: defaultUFactorToMG),
        _ => throw InvalidMassUnitException()
      };
  String toJSON() => name;

  @override
  String toString() => name;
}

const mg = MG._();

class MG extends MassUnit {
  const MG._() : super(name: "mg", factorToMG: 1);

  @override
  operator ==(Object other) => other is MG;

  @override
  int get hashCode => super.name.hashCode;
}

const mcg = MCG._();

class MCG extends MassUnit {
  const MCG._() : super(name: "mcg", factorToMG: 0.001);

  @override
  operator ==(Object other) => other is MCG;

  @override
  int get hashCode => super.name.hashCode;
}

const nanoGr = NanoGr._();

class NanoGr extends MassUnit {
  const NanoGr._() : super(name: "nanogr", factorToMG: 0.000001);

  @override
  operator ==(Object other) => other is NanoGr;

  @override
  int get hashCode => super.name.hashCode;
}

class U extends MassUnit {
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
