import 'package:unit_calc/src/calc/utils.dart';
import 'package:unit_calc/src/exceptions.dart';
import 'package:unit_calc/unit_calc.dart';

/// A given Time \
/// Examples: `5 min`, `7 hr`
class Time implements Number, Comparable<Time> {
  final num _value;
  final TimeUnit unit;

  const Time(this._value, this.unit) : assert(_value >= 0);
  const Time.seconds(this._value) : unit = TimeUnit.second, assert(_value >= 0);
  const Time.hours(this._value) : unit = TimeUnit.hour, assert(_value >= 0);
  const Time.minutes(this._value) : unit = TimeUnit.minute, assert(_value >= 0);
  const Time.zero([TimeUnit? unit])
    : _value = 0,
      unit = unit ?? TimeUnit.second;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Time &&
          runtimeType == other.runtimeType &&
          asNumber(other.unit) == other.asNumber(other.unit);

  factory Time.ofDuration(Duration duration) =>
      Time(duration.inMilliseconds / 1000, TimeUnit.second);

  Duration get asDuration =>
      Duration(milliseconds: (asNumber(TimeUnit.second) * 1000).round());

  Time as([TimeUnit? toTime]) =>
      Time(_value * unit.convertFactor(toTime: toTime ?? unit), toTime ?? unit);

  num asNumber([TimeUnit? toTime]) => as(toTime)._value;
  Time operator -(Time other) =>
      Time(asNumber(other.unit) - other.asNumber(other.unit), other.unit);

  Time operator +(Time other) =>
      Time(asNumber(other.unit) + other.asNumber(other.unit), other.unit);

  bool operator >(Time other) =>
      asNumber(other.unit) > other.asNumber(other.unit);
  bool operator <(Time other) =>
      asNumber(other.unit) < other.asNumber(other.unit);

  bool operator <=(Time other) =>
      identical(this, other) ||
      asNumber(other.unit) <= other.asNumber(other.unit);

  bool operator >=(Time other) =>
      identical(this, other) ||
      asNumber(other.unit) >= other.asNumber(other.unit);

  @override
  int compareTo(Time other) => asNumber(unit).compareTo(other.asNumber(unit));

  @override
  String toDisplayString([DigitPrecision? override, NumberFormat? format]) =>
      '${NumberUtils.toDecimalString(_value, override, format)} ${unit.displayName}';

  @override
  String toString() => toDisplayString();

  @override
  String toJson() {
    return "$_value ${unit.toJson()}";
  }

  factory Time.fromJson(String json) =>
      switch (ParseUtilities.splitString(json)) {
        (String value, [String mass]) => Time(
          num.parse(value),
          TimeUnit.fromJson(mass),
        ),
        _ => throw InvalidJsonException(json),
      };

  @override
  int get hashCode => Object.hash(_value, unit);

  String _timeDigits(TimeUnit unit) => switch (unit) {
    TimeUnit.hour => asNumber(unit),
    _ => asNumber(unit) % 60,
  }.floor().toString().padLeft(2, "0");

  String get asHHmmSS =>
      '${_timeDigits(TimeUnit.hour)}:${_timeDigits(TimeUnit.minute)}:${_timeDigits(TimeUnit.second)}';

  // ignore: non_constant_identifier_names
  String get asHHmmSS_short => switch (asHHmmSS) {
    final hHmmSS when hHmmSS.startsWith("00:") => hHmmSS.substring(3),
    final hHmmSS => hHmmSS,
  };

  ///Returns the amount of complete seconds in [Time]
  /// Example: (5.9 seconds).toFullSeconds=5
  int get toFullSeconds => asNumber(TimeUnit.second).floor();

  Time truncatedDivision(num other) =>
      Time.seconds(asNumber(TimeUnit.second) ~/ other);
}
