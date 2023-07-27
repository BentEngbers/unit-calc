enum VolumeUnit {
  ml(1, "ml");

  final int factorMl;
  final String displayName;
  const VolumeUnit(this.factorMl, this.displayName);
  static VolumeUnit volumeFromString(String str) =>
      VolumeUnit.values.firstWhere((e) => e.displayName == str);
  factory VolumeUnit.fromJson(String str) => volumeFromString(str);

  String toJson() => displayName;
  num convertFactor({required VolumeUnit to}) => factorMl / to.factorMl;
}
