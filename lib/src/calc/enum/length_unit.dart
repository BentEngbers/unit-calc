enum LengthUnit {
  meter(100, "m"),
  centiMeter(1, "cm");

  final String displayName;
  final int factorToCentiMeter;
  const LengthUnit(this.factorToCentiMeter, this.displayName);

  double convertFactor({required LengthUnit toLength}) =>
      toLength.factorToCentiMeter / factorToCentiMeter;

  String toJson() => displayName;
  factory LengthUnit.fromJson(String json) =>
      LengthUnit.values.firstWhere((e) => e.displayName == json);
}
