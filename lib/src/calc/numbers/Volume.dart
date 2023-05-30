import 'package:meta/meta.dart';

import 'Number.dart';

@immutable
abstract class AbstractVolume extends Number {
  AbstractVolume(double value) : super(value);

  String _todisplayString(String number) => '$number ml';

  @override
  String toFixedDecimalString({int minDigit = 1, int maxDigit = 1}) =>
      _todisplayString(
          super.toFixedDecimalString(minDigit: minDigit, maxDigit: maxDigit));

  @override
  String toString() => super.toDynamicDecimalString;
}

@sealed
@immutable
class Volume extends AbstractVolume {
  Volume(double value) : super(value);
  Volume operator +(Volume volume) => Volume(super.value + volume.value);
  Volume operator -(Volume volume) => Volume(super.value - volume.value);
  static Volume fromJson(double value) => Volume(value);
  static double toJSON(Volume volume) => volume.value;
}
