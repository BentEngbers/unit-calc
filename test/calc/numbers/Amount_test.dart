import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:unit_calc/src/Exceptions.dart';
import 'package:unit_calc/src/calc/enum/ConcentrationUnit.dart';
import 'package:unit_calc/src/calc/numbers/Amount.dart';
import 'package:unit_calc/src/calc/numbers/AmountPerML.dart';
import 'package:unit_calc/src/calc/numbers/Volume.dart';

void main() {
  group('Amount', () {
    test("throws an error if initialized with negative number", () {
      expect(() => Amount(-1, mcg),
          throwsA(const TypeMatcher<NegativeNumberException>()));
    });
    test("check the to string method", () {
      expect(Amount(2.1, mg).toString(), "2.1 mg");
    });
    test("equality different ConcentrationUnit",
        () => {expect(Amount(5, mcg) == Amount(5, mg), false)});
    test("equality different value",
        () => {expect(Amount(5, mg) == Amount(6, mg), false)});
    test("equality true", () => {expect(Amount(6, mg) == Amount(6, mg), true)});

    for (var tuple in [
      Tuple2(Amount(5, mg), Amount(5, mg)),
      Tuple2(Amount(7, mcg), Amount(0.007, mg)),
      Tuple2(Amount(9, nanogr), Amount(0.009, mcg)),
      Tuple2(Amount(6000000, nanogr), Amount(6, mg))
    ]) {
      test(
          "Test convertTo from ${tuple.value1} to ${tuple.value2.unit.name}",
          () => {
                expect(tuple.value1.convertTo(tuple.value2.unit), tuple.value2)
              });
    }
    for (var tuple in [
      Tuple3(Amount(5, mg), AmountPerML(5, mg), Volume(1)),
      Tuple3(Amount(7, mcg), AmountPerML(0.007, mg), Volume(1)),
      Tuple3(Amount(18, nanogr), AmountPerML(0.009, mcg), Volume(2)),
      Tuple3(Amount(60000000, nanogr), AmountPerML(6, mg), Volume(10))
    ]) {
      test("Test dividing ${tuple.value1} by ${tuple.value2}",
          () => {expect(tuple.value1 / tuple.value2, tuple.value3)});
    }
  });
}
