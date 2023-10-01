extension TimerDurations on int {
  int get hours => this ~/ 3600;
  int get minutes => (this % 3600) ~/ 60;
  int get seconds => this % 60;

  /// Formats a given [time] integer to a string in the format "00" or "0N" (where N is the time value).
  String get formatTime => this < 10 ? '0$this' : '$this';
}
