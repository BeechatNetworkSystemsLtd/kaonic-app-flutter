import 'package:intl/intl.dart';
import 'package:kaonic/generated/l10n.dart';

extension DateTimeExtension on DateTime {
  String get getCallDuration {
    final now = DateTime.now();
    final duration = now.difference(this);

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    } else {
      return '${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
  }

  String get messageTime {
    return DateFormat('HH:mm').format(this);
  }

  String get formatedDay {
    if (isToday) return S.current.today;

    return DateFormat('MMM d').format(this);
  }

  bool get isToday {
    final now = DateTime.now();

    return now.year == year && now.month == month && now.day == day;
  }
}
