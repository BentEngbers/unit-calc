enum Diluent { NACL, GLUCOSE }

extension DiluentExtention on Diluent {
  /// Factor between the current TimeUnit and Min.
  /// used in changing units
  String get value {
    switch (this) {
      case Diluent.NACL:
        return "NaCl 0.9%";
      case Diluent.GLUCOSE:
        return "Glucose 5%";
    }
  }
}
