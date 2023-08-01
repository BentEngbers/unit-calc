enum TimeUnit {
  seconds(1, "seconds"),
  min(60, "min"),
  hr(60 * 60, "hr");

  final int factorSeconds;
  final String displayName;
  const TimeUnit(this.factorSeconds, this.displayName);

  double convertFactor({required TimeUnit toTime}) =>
      factorSeconds / toTime.factorSeconds;

  String toJson() => name;

  factory TimeUnit.fromJson(String json) =>
      TimeUnit.values.firstWhere((e) => e.displayName == json);
}
