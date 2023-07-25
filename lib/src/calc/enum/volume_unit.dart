enum VolumeUnit {
  ml(1, "ml");

  final int factorMl;
  final String displayName;
  const VolumeUnit(this.factorMl, this.displayName);
  static VolumeUnit volumeFromString(String str) =>
      VolumeUnit.values.firstWhere((e) => e.name == str);
  factory VolumeUnit.fromJson(String str) => volumeFromString(str);

  num convertFactor({required VolumeUnit to}) => factorMl / to.factorMl;
}
