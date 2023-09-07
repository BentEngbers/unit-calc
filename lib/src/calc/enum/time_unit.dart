enum TimeUnit {
  second(1, "seconds"),
  minute(60, "min"),
  hour(60 * 60, "hr");

  final int factorSeconds;
  final String displayName;
  const TimeUnit(this.factorSeconds, this.displayName);

  double convertFactor({required TimeUnit toTime}) =>
      factorSeconds / toTime.factorSeconds;

  String toJson() => displayName;

  factory TimeUnit.fromJson(String json) =>
      TimeUnit.values.firstWhere((e) => e.displayName == json);
}
