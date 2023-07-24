enum VolumeUnit {
  ml(1, "ml");

  final int factorMl;
  final String f;
  const VolumeUnit(this.factorMl, this.f);
  VolumeUnit volumeFromString(String str) =>
      VolumeUnit.values.firstWhere((e) => e.name == str);
}
