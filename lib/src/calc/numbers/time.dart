import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';
import 'package:unit_calc/src/exceptions.dart';
import 'package:unit_calc/unit_calc.dart';

class Time implements Number, Comparable<Time> {
  final num _value;
  final TimeUnit unit;

  const Time(this._value, this.unit) : assert(_value >= 0);
  const Time.seconds(this._value)
      : unit = TimeUnit.second,
        assert(_value >= 0);
  const Time.hours(this._value)
      : unit = TimeUnit.hour,
        assert(_value >= 0);
  const Time.minutes(this._value)
      : unit = TimeUnit.minute,
        assert(_value >= 0);
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

  get asDuration =>
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

  String get asHHmmSS {
    final fullHours = asNumber(TimeUnit.hour).floor();
    final fullMinutes = (asNumber(TimeUnit.minute) % 60).floor();
    final fullSeconds = (asNumber(TimeUnit.second) % 60).floor();

    final hourString = fullHours < 10 ? "0$fullHours" : "$fullHours";
    final minutesString = fullMinutes < 10 ? "0$fullMinutes" : "$fullMinutes";
    final secondsString = fullSeconds < 10 ? "0$fullSeconds" : "$fullSeconds";
    return '$hourString:$minutesString:$secondsString';
  }

  String get asHHmmSS_short {
    final hhmmss = asHHmmSS;
    return hhmmss.startsWith("00:") ? hhmmss.substring(3) : hhmmss;
  }

  ///Returns the amount of complete seconds in [Time]
  /// Example: (5.9 seconds).toFullSeconds=5
  int get toFullSeconds => asNumber(TimeUnit.second).floor();

  Time truncatedDivision(num other) =>
      Time.seconds(asNumber(TimeUnit.second) ~/ other);
}
