enum TimeUnit {
  min(1),
  hr(1 / 60);

  final double factorMin;
  const TimeUnit(this.factorMin);
  TimeUnit timeFromString(String str) =>
      TimeUnit.values.firstWhere((e) => e.name == str);
}
