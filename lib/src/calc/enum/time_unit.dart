enum TimeUnit {
  min(1, "min"),
  hr(60, "hr");

  final int factorMin;
  final String displayName;
  const TimeUnit(this.factorMin, this.displayName);
  TimeUnit timeFromString(String str) =>
      TimeUnit.values.firstWhere((e) => e.name == str);
  static double convertFactorOnlyTime(
          {required TimeUnit fromTime, required TimeUnit toTime}) =>
      toTime.factorMin / fromTime.factorMin;
}
