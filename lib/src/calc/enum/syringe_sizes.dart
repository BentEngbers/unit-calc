import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/volume.dart';

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
  Volume get volume => Volume(value, VolumeUnit.milliLiters);
}
