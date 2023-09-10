import 'package:test/test.dart';
import 'package:unit_calc/unit_calc.dart';

import 'mass_per_volume_test.dart';

void main() {
  group("MassPerMassTime", () {
    test("roundTrip json", () {
      const massPerMassTime =
          MassPerMassTime(20, MassUnit.gram, MassUnit.kiloGram, TimeUnit.hour);
      expect(
        MassPerMassTime.fromJson(massPerMassTime.toJson()),
        massPerMassTime,
      );
    });
    test("roundTrip json", () {
      const massPerMassTime =
          MassPerMassTime(20, MassUnit.gram, MassUnit.kiloGram, TimeUnit.hour);
      const massPerMassTime2 = MassPerMassTime(
        20.22,
        MassUnit.gram,
        MassUnit.kiloGram,
        TimeUnit.hour,
      );
      expect(massPerMassTime.hashCode, isNot(massPerMassTime2.hashCode));
      expect(massPerMassTime.hashCode, massPerMassTime.hashCode);
    });
    test("multiply by mass", () {
      const massPerMassTime =
          MassPerMassTime(20, MassUnit.gram, MassUnit.kiloGram, TimeUnit.hour);
      expect(
        massPerMassTime * const Mass(5, MassUnit.kiloGram),
        const MassPerTime(100, MassUnit.gram, TimeUnit.hour),
      );
    });
    test("roundTrip json", () {
      expect(
        () => MassPerMassTime.fromJson("20 gr/kg"),
        throwsInvalidJsonException,
      );
    });
    test("toDisplayString", () {
      const massPerMassTime = MassPerMassTime(
        20.22,
        MassUnit.gram,
        MassUnit.kiloGram,
        TimeUnit.hour,
      );
      expect(massPerMassTime.toString(), "20.2 g/kg/hr");
    });
    test("perKg constructor", () {
      expect(
        const MassPerMassTime.perKg(20, MassUnit.gram, TimeUnit.hour),
        const MassPerMassTime(
          20,
          MassUnit.gram,
          MassUnit.kiloGram,
          TimeUnit.hour,
        ),
      );
      expect(
        () => MassPerMassTime.perKg(-1, MassUnit.gram, TimeUnit.hour),
        throwsAssertionError,
      );
    });
  });
}
