enum TimeUnit {
  min(1, "min"),
  hr(60, "hr");

  final int factorMin;
  final String displayName;
  const TimeUnit(this.factorMin, this.displayName);

  double convertFactor({required TimeUnit toTime}) =>
      toTime.factorMin / factorMin;

  String toJson() => name;

  factory TimeUnit.fromJson(String json) =>
      TimeUnit.values.firstWhere((e) => e.name == json);
}
