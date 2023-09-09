// ignore: camel_case_types
import 'package:test/test.dart';
import 'package:unit_calc/unit_calc.dart';

typedef _testCase = ({LengthUnit unit, String name});
typedef _TimeUnitConversionTestCase = ({
  LengthUnit unit1,
  LengthUnit unit2,
  num value,
});
const List<_testCase> _testCases = [
  (unit: LengthUnit.centiMeter, name: "cm"),
  (unit: LengthUnit.meter, name: "m")
];
void main() {
  const centiMeter = LengthUnit.centiMeter;
  const meter = LengthUnit.meter;
  const timeTests = <_TimeUnitConversionTestCase>[
    (unit1: centiMeter, unit2: centiMeter, value: 1),
    (unit1: meter, unit2: centiMeter, value: 100),
    (unit1: centiMeter, unit2: meter, value: 1 / 100),
    (unit1: meter, unit2: meter, value: 1),
  ];
  for (final tuple in timeTests) {
    test("test conversion from ${tuple.unit1} to ${tuple.unit2}", () {
      expect(tuple.unit1.convertFactor(toLength: tuple.unit2), tuple.value);
    });
  }
  for (final (:name, :unit) in _testCases) {
    group("$name:", () {
      test("json roundtrip", () {
        expect(LengthUnit.fromJson(unit.toJson()), unit);
      });
      test("json from string", () {
        expect(LengthUnit.fromJson(name), unit);
      });
    });
  }
}
