import 'package:test/test.dart';
import 'package:unit_calc/src/calc/enum/mass_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_mass_time.dart';
import 'package:unit_calc/unit_calc.dart';

import 'mass_per_volume_test.dart';

void main() {
  group("MassPerMassTime", () {
    test("roundTrip json", () {
      const massPerMassTime =
          MassPerMassTime(20, gram, kiloGram, TimeUnit.hour);
      expect(
        MassPerMassTime.fromJson(massPerMassTime.toJson()),
        massPerMassTime,
      );
    });
    test("roundTrip json", () {
      const massPerMassTime =
          MassPerMassTime(20, gram, kiloGram, TimeUnit.hour);
      const massPerMassTime2 =
          MassPerMassTime(20.22, gram, kiloGram, TimeUnit.hour);
      expect(massPerMassTime.hashCode, isNot(massPerMassTime2.hashCode));
      expect(massPerMassTime.hashCode, massPerMassTime.hashCode);
    });
    test("multiply by mass", () {
      const massPerMassTime =
          MassPerMassTime(20, gram, kiloGram, TimeUnit.hour);
      expect(
        massPerMassTime * const Mass(5, kiloGram),
        const MassPerTime(100, gram, TimeUnit.hour),
      );
    });
    test("roundTrip json", () {
      expect(() => MassPerMassTime.fromJson("20 gr/kg"),
          throwsInvalidJsonException);
    });
    test("toDisplayString", () {
      const massPerMassTime =
          MassPerMassTime(20.22, gram, kiloGram, TimeUnit.hour);
      expect(massPerMassTime.toString(), "20.2 g/kg/hr");
    });
    test("perKg constructor", () {
      expect(
        const MassPerMassTime.perKg(20, gram, TimeUnit.hour),
        const MassPerMassTime(20, gram, kiloGram, TimeUnit.hour),
      );
      expect(
        () => MassPerMassTime.perKg(-1, gram, TimeUnit.hour),
        throwsAssertionError,
      );
    });
  });
}
