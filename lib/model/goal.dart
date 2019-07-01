import 'package:flutter/widgets.dart';

class Goal {
  String name;
  DateTime date;
  Duration timeLeft;

  Goal({@required this.name, @required this.date});

  String leftTime() {
    if (timeLeft != null) {
      if (!timeLeft.isNegative) {
        int daysLeft = timeLeft.inDays;
        int hoursLeft = timeLeft.inHours - timeLeft.inDays * 24;
        int minutesLeft = timeLeft.inMinutes - timeLeft.inHours * 60;
        int secondsLeft = timeLeft.inSeconds - timeLeft.inMinutes * 60;
        int milisecondsLeft = timeLeft.inMilliseconds - timeLeft.inSeconds * 1000;

        return 'Осталолось $daysLeft дней и $hoursLeft:$minutesLeft:$secondsLeft:$milisecondsLeft';
      } else {
        return 'Дата цели достигнута';
      }
    } else {
      return '';
    }
  }
}
