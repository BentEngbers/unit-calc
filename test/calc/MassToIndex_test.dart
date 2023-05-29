import 'package:dartz/dartz.dart';

import 'package:test/test.dart';
import 'package:unit_calc/src/calc/MassToIndex.dart';
import 'package:unit_calc/src/calc/numbers/Mass.dart';

main() {
  group("Index to Mass", () {
    for (var element in [
      Tuple2(1, Mass(0.1)),
      Tuple2(0, Mass(0.0)),
      Tuple2(90, Mass(9)),
      Tuple2(99, Mass(9.9)),
      Tuple2(100, Mass(10)),
      Tuple2(101, Mass(11)),
    ]) {
      test(
          "Test correct calculation ${element.value1} to ${element.value2.value}",
          () {
        expect(getPatientMass(element.value1), element.value2);
      });
    }
  });
  group("Mass to Index", () {
    for (var element in [
      Tuple2(Mass(0.1), 1),
      Tuple2(Mass(0.0), 0),
      Tuple2(Mass(9), 90),
      Tuple2(Mass(9.9), 99),
      Tuple2(Mass(10), 100),
      Tuple2(Mass(11), 101),
    ]) {
      test(
          "Test correct calculation ${element.value1.value} to ${element.value2}",
          () {
        expect(getMassIndex(element.value1), element.value2);
      });
    }
  });
  group("Test getMassIndex and getPatientMass together", () {
    for (var element in [Mass(4), Mass(10), Mass(70)]) {
      test(
          "Test correct getMassIndex and getPatientMass together for Mass: $element",
          () {
        expect(getPatientMass(getMassIndex(element)), element);
      });
    }
  });
}
