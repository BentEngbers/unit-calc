import 'package:test/test.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_mass_time.dart';
import 'package:unit_calc/unit_calc.dart';

import 'mass_per_volume_test.dart';

void main() {
  group("MassPerMassTime", () {
    test("roundTrip json", () {
      const massPerMassTime = MassPerMassTime(20, gram, kiloGram, TimeUnit.hr);
      expect(
          MassPerMassTime.fromJson(massPerMassTime.toJson()), massPerMassTime);
    });
    test("roundTrip json", () {
      const massPerMassTime = MassPerMassTime(20, gram, kiloGram, TimeUnit.hr);
      const massPerMassTime2 =
          MassPerMassTime(20.22, gram, kiloGram, TimeUnit.hr);
      expect(massPerMassTime.hashCode, isNot(massPerMassTime2.hashCode));
      expect(massPerMassTime.hashCode, massPerMassTime.hashCode);
    });
    test("multiply by mass", () {
      const massPerMassTime = MassPerMassTime(20, gram, kiloGram, TimeUnit.hr);
      expect(massPerMassTime * Mass(5, kiloGram),
          MassPerTime(100, gram, TimeUnit.hr));
    });
    test("roundTrip json", () {
      expect(() => MassPerMassTime.fromJson("20 gr/kg"), throwsFormatException);
    });
    test("toDisplayString", () {
      const massPerMassTime =
          MassPerMassTime(20.22, gram, kiloGram, TimeUnit.hr);
      expect(massPerMassTime.toString(), "20.2 g/kg/hr");
    });
    test("perKg constructor", () {
      expect(MassPerMassTime.perKg(20, gram, TimeUnit.hr),
          MassPerMassTime(20, gram, kiloGram, TimeUnit.hr));
      expect(() => MassPerMassTime.perKg(-1, gram, TimeUnit.hr),
          throwAssertionError);
    });
  });
}
