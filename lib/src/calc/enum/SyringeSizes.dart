import 'package:unit_calc/src/calc/numbers/Volume.dart';

enum SyringeSizes {
  ml1(1),
  ml2_5(2.5),
  ml5(5),
  ml10(10),
  ml20(20),
  ml25(25),
  ml30(30),
  ml50(50);

  final double value;
  const SyringeSizes(this.value);
  Volume get volume => Volume(value);
}

extension SyringeSizesExtention on SyringeSizes {
  /// The amount of ml. (ML10 returns 10, etc.)
  double get _value {
    //SyringeSizes.values
    switch (this) {
      case SyringeSizes.ml1:
        return 1;
      case SyringeSizes.ml2_5:
        return 2.5;
      case SyringeSizes.ml5:
        return 5;
      case SyringeSizes.ml10:
        return 10;
      case SyringeSizes.ml20:
        return 20;
      case SyringeSizes.ml25:
        return 25;
      case SyringeSizes.ml30:
        return 30;
      case SyringeSizes.ml50:
        return 50;
    }
  }

  Volume get volume => Volume(_value);
}
