class ThailandTimeUtils {
  static DateTime getThailandDate() {
    var now = DateTime.now().toUtc();
    var thailandTime = now.add(const Duration(hours: 7));
    return DateTime(thailandTime.year, thailandTime.month, thailandTime.day).add(const Duration(hours: 7));
  }

  static DateTime getThailandNow() {
    var thisTime = DateTime.now().toUtc();
    return thisTime.add(const Duration(hours: 7));
  }




  static DateTime getNextThailandMidnight() {
    var now = DateTime.now().toUtc();
    var thailandMidnight = DateTime.utc(now.year, now.month, now.day, 17, 0, 0);

    if (now.isAfter(thailandMidnight)) {
      thailandMidnight = thailandMidnight.add(const Duration(days: 1));
    }

    return thailandMidnight;
  }
}
