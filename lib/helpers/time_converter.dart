const SECONDS_IN_MINUTE = 60;
const SECONDS_IN_HOUR = 60*SECONDS_IN_MINUTE;
const SECONDS_IN_DAY = 24*SECONDS_IN_HOUR;
const SECONDS_IN_MONTH = 30*SECONDS_IN_DAY;
const SECONDS_IN_YEAR = 12*SECONDS_IN_MONTH;

String getTimeDiff(DateTime created) {
  var dateUtc = DateTime.now();

  var dateNow = dateUtc.toLocal();
  var dateCreated = created.toLocal();

  final difference = dateNow.difference(dateCreated);

  var timeDiff = difference.inSeconds;

  if (timeDiff <= SECONDS_IN_MINUTE) {
    return "${difference.inSeconds}s";
  } else if (timeDiff <= SECONDS_IN_HOUR) {
    return "${difference.inMinutes}m";
  } else if (timeDiff <= SECONDS_IN_DAY) {
    return "${difference.inHours}h";
  } else if (timeDiff <= SECONDS_IN_MONTH){
    return "${difference.inDays}d";
  } else if (timeDiff <= SECONDS_IN_YEAR) {
    return "${difference.inDays ~/ 30}mo";
  } else {
    return "${difference.inDays ~/ 365}y";
  }
}