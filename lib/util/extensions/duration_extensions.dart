extension DurationExtension on Duration {
  /// Formats the duration into string signifying days, hours, minutes and seconds.
  String get formattedValue {
    int seconds = this.inSeconds;

    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;

    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;

    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    const List<String> tokens = [];

    if (days != 0) {
      tokens.add('$days ${days == 1 ? "day" : "days"}');
    }

    if (tokens.isNotEmpty || hours != 0) {
      tokens.add('$hours ${hours == 1 ? "hour" : "hours"}');
    }

    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('$minutes ${minutes == 1 ? "minute" : "minutes"}');
    }

    tokens.add('$seconds ${seconds == 1 ? "second" : "seconds"}');

    return tokens.join(' and ');
  }
}
