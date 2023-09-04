/// A nice touch from gskinner:
/// https://github.com/gskinner/flutter_animate/blob/main/lib/src/extensions/num_duration_extensions.dart

/// Adds extensions to num (ie. int & double) to make creating durations simple:
///
/// ```
/// 200.ms // equivalent to Duration(milliseconds: 200)
/// 3.seconds // equivalent to Duration(milliseconds: 3000)
/// 1.5.days // equivalent to Duration(hours: 36)
/// ```
extension NumDurationExtensions on num {
  Duration get microseconds => Duration(microseconds: round());
  Duration get ms => (this * 1000).microseconds;
  Duration get milliseconds => (this * 1000).microseconds;
  Duration get seconds => (this * 1000 * 1000).microseconds;
  Duration get minutes => (this * 1000 * 1000 * 60).microseconds;
  Duration get hours => (this * 1000 * 1000 * 60 * 60).microseconds;
  Duration get days => (this * 1000 * 1000 * 60 * 60 * 24).microseconds;
}

extension DurationExt on Duration {
  bool get positive => compareTo(Duration.zero) > 0;

  double operator /(Duration quotient) {
    return inMicroseconds / quotient.inMicroseconds;
  }
}
