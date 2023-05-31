import 'package:test/test.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/numbers/amount.dart';
import 'package:unit_calc/src/calc/numbers/amount_per_ml.dart';
import 'package:unit_calc/src/calc/numbers/Volume.dart';

typedef UnitConversion = ({Amount from, Amount to});
typedef UnitConversionDivision = ({
  Amount amount,
  AmountPerML divisor,
  Volume result,
});
void main() {
  group('Amount', () {
    test("throws an error if initialized with negative number", () {
      expect(() => Amount(-1, mcg), throwsA(isA<AssertionError>()));
    });
    test("check the to string method", () {
      expect(Amount(2.1, mg).toString(), "2.1 mg");
    });
    test("equality different ConcentrationUnit",
        () => {expect(Amount(5, mcg) == Amount(5, mg), false)});
    test("equality different value",
        () => {expect(Amount(5, mg) == Amount(6, mg), false)});
    test("equality true", () => {expect(Amount(6, mg) == Amount(6, mg), true)});
    const cases = <UnitConversion>[
      (from: Amount(5, mg), to: Amount(5, mg)),
      (from: Amount(7, mcg), to: Amount(0.007, mg)),
      (from: Amount(9, nanoGr), to: Amount(0.009, mcg)),
      (from: Amount(6000000, nanoGr), to: Amount(6, mg))
    ];
    for (final testCase in cases) {
      final (:from, :to) = testCase;
      test("Test convertTo from ${from} to ${to.unit.name}", () {
        expect(from.convertTo(from.unit), to);
      });
    }
    const divisionTestCases = <UnitConversionDivision>[
      (
        amount: Amount(5, mg),
        divisor: AmountPerML(5, mg),
        result: Volume(1),
      ),
      (
        amount: Amount(7, mcg),
        divisor: AmountPerML(0.007, mg),
        result: Volume(1)
      ),
      (
        amount: Amount(7, mcg),
        divisor: AmountPerML(0.007, mg),
        result: Volume(1)
      ),
      (
        amount: Amount(18, nanoGr),
        divisor: AmountPerML(0.009, mcg),
        result: Volume(2)
      ),
      (
        amount: Amount(60000000, nanoGr),
        divisor: AmountPerML(6, mg),
        result: Volume(10)
      ),
    ];
    for (final tuple in divisionTestCases) {
      final (:amount, :divisor, :result) = tuple;
      test("Test dividing ${amount} by ${divisor}",
          () => {expect(amount / divisor, result)});
    }
  });
}
