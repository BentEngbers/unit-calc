import 'package:unit_calc/src/calc/numbers/Volume.dart';

enum SyringeSizes {
  ML1,
  ML2_5,
  ML5,
  ML10,
  ML20,
  ML25,
  ML30,
  ML50,
}

extension SyringeSizesExtention on SyringeSizes {
  /// The amount of ml. (ML10 returns 10, etc.)
  double get _value {
    //SyringeSizes.values
    switch (this) {
      case SyringeSizes.ML1:
        return 1;
      case SyringeSizes.ML2_5:
        return 2.5;
      case SyringeSizes.ML5:
        return 5;
      case SyringeSizes.ML10:
        return 10;
      case SyringeSizes.ML20:
        return 20;
      case SyringeSizes.ML25:
        return 25;
      case SyringeSizes.ML30:
        return 30;
      case SyringeSizes.ML50:
        return 50;
    }
  }

  Volume get volume => Volume(_value);
}
