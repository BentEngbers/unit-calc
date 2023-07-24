import '../../exceptions.dart';

const _nanoGrName = "nanogr";
const _mcgName = "mcg";
const _mgName = "mg";
const _kgName = "kg";
const _gramName = "g";
const _uName = "U";

const milliGram = MilliGram._();
const microGram = MicroGram._();
const nanoGram = NanoGram._();
const gram = Gram._();
const kiloGram = KiloGram._();

sealed class MassUnit {
  final String name;
  final num factorNanoGr;
  const MassUnit({required this.name, required this.factorNanoGr});

  factory MassUnit.fromJson(String json, {num? uFactorToNg}) => switch (json) {
        _mgName => milliGram,
        _mcgName => microGram,
        _nanoGrName => nanoGram,
        _kgName => kiloGram,
        _uName => U(factorToNg: uFactorToNg!),
        _ => throw InvalidMassUnitException()
      };
  String toJSON() => name;

  @override
  String toString() => name;
}

class NanoGram extends MassUnit {
  const NanoGram._() : super(name: _nanoGrName, factorNanoGr: 1);

  @override
  operator ==(Object other) => other is NanoGram;

  @override
  int get hashCode => super.name.hashCode;
}

class MicroGram extends MassUnit {
  const MicroGram._() : super(name: _mcgName, factorNanoGr: 1000);

  @override
  operator ==(Object other) => other is MicroGram;

  @override
  int get hashCode => super.name.hashCode;
}

class MilliGram extends MassUnit {
  const MilliGram._() : super(name: _mgName, factorNanoGr: 1000000);

  @override
  operator ==(Object other) => other is MilliGram;

  @override
  int get hashCode => super.name.hashCode;
}

class Gram extends MassUnit {
  const Gram._() : super(name: _gramName, factorNanoGr: 1000000000);
  @override
  operator ==(Object other) => other is Gram;

  @override
  int get hashCode => Object.hash(name, factorNanoGr);
}

class KiloGram extends MassUnit {
  const KiloGram._() : super(name: _kgName, factorNanoGr: 1000000000000);
  @override
  operator ==(Object other) => other is KiloGram;

  @override
  int get hashCode => Object.hash(name, factorNanoGr);
}

class U extends MassUnit {
  const U({required num factorToNg})
      : super(name: _uName, factorNanoGr: factorToNg);
  @override
  operator ==(Object other) => other is U && other.factorNanoGr == factorNanoGr;

  @override
  int get hashCode => Object.hash(name, factorNanoGr);

  @override
  String toString() {
    return "U($factorNanoGr)";
  }
}
