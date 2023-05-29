import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/ConcentrationUnit.dart';
import 'package:unit_calc/src/calc/numbers/AmountPerTime.dart';
import 'package:unit_calc/src/calc/numbers/VolumePerTime.dart';

import 'Amount.dart';
import 'Volume.dart';

@immutable
class AmountPerML extends AbstractAmount {
  AmountPerML(double value, ConcentrationUnit unit) : super(value, unit);

  //TODO: test this function
  Amount operator *(Volume volume) => Amount(volume.value * value, unit);

  //TODO: test this function
  AmountPerTime multiply(VolumePerTime volumePerTime) =>
      AmountPerTime(value * volumePerTime.value, unit, volumePerTime.timeUnit);

  String _todisplayString(String number) => "$number/ml";

  @override
  String toFixedDecimalString({int minDigit = 1, int maxDigit = 1}) =>
      _todisplayString(
          super.toFixedDecimalString(minDigit: minDigit, maxDigit: maxDigit));

  @override
  String toString() => super.toDynamicDecimalString;
}
