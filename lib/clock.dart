import 'dart:async' show Timer;

enum Season {
  winter,
  spring,
  summer,
  autumn;

  @override
  String toString() => switch (this) {
    winter => 'winter',
    spring => 'spring',
    summer => 'summer',
    autumn => 'autumn',
  };
}

enum TimeOfDay {
  night,
  day;

  @override
  String toString() => switch (this) {
    night => 'night',
    day => 'day',
  };
}

class Clock {
  Clock(this.callback);

  final void Function() callback;
  int tick = 0;
  Season season = .winter;
  TimeOfDay timeOfDay = .night;
  int days = 0;
  int hours = 0;
  int minutes = 0;

  static const _tickInterval = Duration(milliseconds: 250);
  Timer? _timer;

  void _nativeCallback(Timer _) {
    tick += 1;
    final daysDouble = tick.toDouble() / 100.0;
    days = daysDouble.floor();
    season = switch (days) {
      < 60 => .winter,
      < 150 => .spring,
      < 240 => .summer,
      < 330 => .autumn,
      _ => .winter,
    };
    final hoursDouble = (daysDouble - days) * 24;
    hours = hoursDouble.floor();

    timeOfDay = switch (hours) {
      < 18 && > 6 => .day,
      _ => .night,
    };
    final minutesDouble = (hoursDouble - hours) * 60;
    minutes = minutesDouble.floor();
    callback();
  }

  void start() {
    _timer = Timer.periodic(_tickInterval, _nativeCallback);
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  String get time {
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} ($timeOfDay) of day ${days + 1} $season';
  }
}
