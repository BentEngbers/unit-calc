class InvalidConcentrationUnitException implements Exception {
  const InvalidConcentrationUnitException();

  @override
  String toString() {
    return 'InvalidConcentrationUnitException:The given string was an invalid ConcentrationUnit';
  }
}
