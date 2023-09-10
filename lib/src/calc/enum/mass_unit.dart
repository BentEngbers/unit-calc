import '../../exceptions.dart';

const _nanoGrName = "nanogr";
const _mcgName = "mcg";
const _mgName = "mg";
const _kgName = "kg";
const _gramName = "g";
const _uName = "U";

sealed class MassUnit {
  final String displayName;
  final num factorNanoGr;
  const MassUnit({required this.displayName, required this.factorNanoGr});
  static const kiloGram = KiloGram._();
  static const gram = Gram._();
  static const milliGram = MilliGram._();
  static const microGram = MicroGram._();
  static const nanoGram = NanoGram._();
  factory MassUnit.fromJson(String json) => switch (json) {
        _mgName => milliGram,
        _mcgName => microGram,
        _nanoGrName => nanoGram,
        _gramName => gram,
        _kgName => kiloGram,
        _ when json.startsWith(_uName) => U(
            factorToNg: num.parse(
              json.replaceFirst("U(factorNanoGr: ", '').replaceFirst(")", ""),
            ),
          ),
        _ => throw const InvalidMassUnitException()
      };

  num convertFactor({required MassUnit to}) => factorNanoGr / to.factorNanoGr;

  String toJson() => displayName;

  @override
  String toString() => displayName;
}

class NanoGram extends MassUnit {
  const NanoGram._() : super(displayName: _nanoGrName, factorNanoGr: 1);

  @override
  bool operator ==(Object other) => other is NanoGram;

  @override
  int get hashCode => Object.hash(displayName, factorNanoGr);
}

class MicroGram extends MassUnit {
  const MicroGram._() : super(displayName: _mcgName, factorNanoGr: 1000);

  @override
  bool operator ==(Object other) => other is MicroGram;

  @override
  int get hashCode => Object.hash(displayName, factorNanoGr);
}

class MilliGram extends MassUnit {
  const MilliGram._() : super(displayName: _mgName, factorNanoGr: 1000000);

  @override
  bool operator ==(Object other) => other is MilliGram;

  @override
  int get hashCode => Object.hash(displayName, factorNanoGr);
}

class Gram extends MassUnit {
  const Gram._() : super(displayName: _gramName, factorNanoGr: 1000000000);
  @override
  bool operator ==(Object other) => other is Gram;

  @override
  int get hashCode => Object.hash(displayName, factorNanoGr);
}

class KiloGram extends MassUnit {
  const KiloGram._() : super(displayName: _kgName, factorNanoGr: 1000000000000);
  @override
  bool operator ==(Object other) => other is KiloGram;

  @override
  int get hashCode => Object.hash(displayName, factorNanoGr);
}

class U extends MassUnit {
  const U({required num factorToNg})
      : super(displayName: _uName, factorNanoGr: factorToNg);
  @override
  bool operator ==(Object other) => other is U && other.factorNanoGr == factorNanoGr;

  @override
  int get hashCode => Object.hash(displayName, factorNanoGr);

  @override
  String toJson() => "U(factorNanoGr: $factorNanoGr)";
}
