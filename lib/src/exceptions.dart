class InvalidMassUnitException implements Exception {
  const InvalidMassUnitException();

  @override
  String toString() =>
      'InvalidMassUnitException: The given string was an invalid MassUnit';
}

class InvalidJsonException implements Exception {
  final String json;
  InvalidJsonException(this.json);

  @override
  String toString() => "InvalidJsonException: \"$json\"";
}
