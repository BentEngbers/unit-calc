import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';
import 'package:unit_calc/unit_calc.dart';

//@JsonSerializable(explicitToJson: true)
class Time implements Number, Comparable<Time> {
  final num _value;
  final TimeUnit unit;

  const Time(this._value, this.unit);
  //assert(_value >= 0);
  const Time.seconds(this._value) : unit = TimeUnit.seconds;
  //assert(_value >= 0);
  const Time.hour(this._value) : unit = TimeUnit.hr;
  //assert(_value >= 0);
  const Time.minutes(this._value) : unit = TimeUnit.min;
  //assert(_value >= 0);
  const Time.zero([TimeUnit? unit])
      : _value = 0,
        unit = unit ?? TimeUnit.seconds;
  factory Time.ofDuration(Duration duration) =>
      Time(duration.inSeconds, TimeUnit.seconds);
  get asDuration =>
      Duration(milliseconds: (asNumber(TimeUnit.seconds) * 1000).round());
  Time as([TimeUnit? toTime]) =>
      Time(_value * unit.convertFactor(toTime: toTime ?? unit), toTime ?? unit);
  num asNumber([TimeUnit? toTime]) => as(toTime)._value;
  Time operator -(Time other) =>
      Time(asNumber(other.unit) - other.asNumber(), other.unit);
  Time operator +(Time other) =>
      Time(asNumber(other.unit) + other.asNumber(), other.unit);
  bool operator >(Time other) => asNumber(other.unit) > other.asNumber();
  bool operator <(Time other) => asNumber(other.unit) < other.asNumber();
  bool operator <=(Time other) =>
      identical(this, other) || asNumber(other.unit) <= other.asNumber();
  bool operator >=(Time other) =>
      identical(this, other) || asNumber(other.unit) >= other.asNumber();

  @override
  int compareTo(Time other) {
    throw asNumber(unit).compareTo(other.asNumber(unit));
  }

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
        _ => throw FormatException("invalid json: \"$json\""),
      };
}
