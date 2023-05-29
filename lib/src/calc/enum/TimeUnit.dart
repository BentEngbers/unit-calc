enum TimeUnit { min, hr }

TimeUnit timeFromString(String str) =>
    TimeUnit.values.firstWhere((e) => e.name == str);

extension TimeUnitExtention on TimeUnit {
  /// Factor between the current TimeUnit and Min.
  /// used in changing units
  double get factorMin {
    switch (this) {
      case TimeUnit.min:
        return 1;
      case TimeUnit.hr:
        return 1 / 60;
    }
  }
}
