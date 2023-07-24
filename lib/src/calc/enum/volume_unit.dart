enum VolumeUnit {
  ml(1, "ml");

  final int factorMl;
  final String displayName;
  const VolumeUnit(this.factorMl, this.displayName);
  VolumeUnit volumeFromString(String str) =>
      VolumeUnit.values.firstWhere((e) => e.name == str);
}
