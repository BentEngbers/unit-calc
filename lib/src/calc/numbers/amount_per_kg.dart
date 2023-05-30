import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';

import 'amount.dart';

@immutable
class AmountPerKG extends AbstractAmount {
  AmountPerKG(double value, ConcentrationUnit unit) : super(value, unit);
  String _todisplayString(String number) => "$number/kg";

  @override
  String toFixedDecimalString({int minDigit = 1, int maxDigit = 1}) =>
      _todisplayString(
          super.toFixedDecimalString(minDigit: minDigit, maxDigit: maxDigit));

  @override
  String toString() => super.toDynamicDecimalString;
}
