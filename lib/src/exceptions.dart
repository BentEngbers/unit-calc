class InvalidMassUnitException implements Exception {
  const InvalidMassUnitException();

  @override
  String toString() {
    return 'InvalidMassUnitException:The given string was an invalid MassUnit';
  }
}
