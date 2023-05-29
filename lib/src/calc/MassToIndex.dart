import 'numbers/Mass.dart';

Mass getPatientMass(int index) {
  if (index < 100) {
    return Mass(index / 10);
  } else {
    return Mass(index.toDouble() - 90);
  }
}

int getMassIndex(Mass weight) {
  if (weight < Mass(10)) {
    return (weight.value * 10).toInt();
  } else {
    return weight.value.toInt() + 90;
  }
}
