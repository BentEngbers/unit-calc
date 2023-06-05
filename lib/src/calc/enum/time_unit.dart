enum TimeUnit {
  min(1, "min"),
  hr(1 / 60, "hr");

  final double factorMin;
  final String f;
  const TimeUnit(this.factorMin, this.f);
  TimeUnit timeFromString(String str) =>
      TimeUnit.values.firstWhere((e) => e.name == str);
}
