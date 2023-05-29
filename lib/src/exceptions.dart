class InvalidConcentrationUnitException implements Exception {
  const InvalidConcentrationUnitException();

  @override
  String toString() {
    return 'InvalidConcentrationUnitException:The given string was an invalid ConcentrationUnit';
  }
}

class NegativeNumberException implements Exception {
  final String _message;

  const NegativeNumberException(this._message);

  @override
  String toString() {
    return 'NegativeNumberException $_message';
  }
}
