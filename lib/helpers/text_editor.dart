String subscribersCount(var subscribersCount) {
  if (subscribersCount < 1000) {
    return "${(subscribersCount.toString())}";
  } else if (subscribersCount < 1000000) {
    return "${(subscribersCount ~/ 1000)}k";
  } else {
    return "${(subscribersCount ~/ 1000000)}m";
  }
}