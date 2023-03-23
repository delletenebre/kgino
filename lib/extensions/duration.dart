extension DurationExtensions on Duration {
  String get formatted {
    var seconds = inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds~/Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    int minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];

    if (days != 0) {
      tokens.add('$days д');
    }

    if (tokens.isNotEmpty || hours != 0){
      tokens.add('$hours ч');
    }

    if (tokens.isNotEmpty || minutes != 0) {
      if (seconds > 30) {
        minutes++;
      }
      if (tokens.isNotEmpty) {
        tokens.add('$minutes м');
      } else {
        tokens.add('$minutes мин');
      }
      
    }

    // if (hours == 0 && seconds > 0) {
    //   tokens.add('$seconds с');
    // }

    if (tokens.isEmpty) {
      tokens.add('$seconds с');
    }

    return tokens.join(' ');
  }

}