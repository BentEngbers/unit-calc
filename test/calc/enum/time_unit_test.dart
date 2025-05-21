import 'package:test/test.dart';
import 'package:unit_calc/unit_calc.dart';

// ignore: camel_case_types
typedef _testCase = ({TimeUnit unit, String name});
typedef _TimeUnitConversionTestCase = ({
  TimeUnit unit1,
  TimeUnit unit2,
  num value,
});
const List<_testCase> _testCases = [
  (unit: TimeUnit.hour, name: "hr"),
  (unit: TimeUnit.minute, name: "min"),
];
void main() {
  const min = TimeUnit.minute;
  const hr = TimeUnit.hour;
  const timeTests = <_TimeUnitConversionTestCase>[
    (unit1: min, unit2: min, value: 1),
    (unit1: hr, unit2: min, value: 60),
    (unit1: min, unit2: hr, value: 1 / 60),
    (unit1: hr, unit2: hr, value: 1),
  ];
  for (final tuple in timeTests) {
    test("test conversion from ${tuple.unit1} to ${tuple.unit2}", () {
      expect(tuple.unit1.convertFactor(toTime: tuple.unit2), tuple.value);
    });
  }
  for (final (:name, :unit) in _testCases) {
    group("$name:", () {
      test("json roundtrip", () {
        expect(TimeUnit.fromJson(unit.toJson()), unit);
      });
      test("json from string", () {
        expect(TimeUnit.fromJson(name), unit);
      });
    });
  }
}
