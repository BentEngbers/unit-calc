import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/ConcentrationUnit.dart';
import 'package:unit_calc/src/calc/numbers/AmountPerML.dart';
import 'package:unit_calc/src/calc/numbers/Mass.dart';

import 'Amount.dart';

@immutable
class AmountPerMLKG extends AbstractAmount {
  AmountPerMLKG(double value, ConcentrationUnit unit) : super(value, unit);
  String _todisplayString(String number) => "$number/ml/kg";

  @override
  String toFixedDecimalString({int minDigit = 1, int maxDigit = 1}) =>
      _todisplayString(
          super.toFixedDecimalString(minDigit: minDigit, maxDigit: maxDigit));

  @override
  String toString() => super.toDynamicDecimalString;

  AmountPerML operator *(Mass mass) => AmountPerML(value * mass.value, unit);
}
