class TimeFormatUtil{
  // 小红书时间格式：刚刚,今天 10:00,昨天 10:00, (今年) 03-10, (再之前) 2019-03-10
  static String format(String timeStr) {
    int curTimestamp = DateTime.now().millisecondsSinceEpoch;
    int timestamp = DateTime.parse(timeStr).millisecondsSinceEpoch;
    int timestampDiff = curTimestamp - timestamp; // 时间戳差

    var curDate = new DateTime.fromMillisecondsSinceEpoch(curTimestamp);
    var tmDate = new DateTime.fromMillisecondsSinceEpoch(timestamp);

    var year = tmDate.year, month = tmDate.month, day = tmDate.day;
    var hour = tmDate.hour, minute = tmDate.minute;

    if(timestampDiff < 60) {
      return '刚刚';
    } else if(curDate.year == year && curDate.month == month && curDate.day == day) {
      return '今天 ' + zeroize(hour) + ':' + zeroize(minute);
    } else {
      var newDate = DateTime.fromMillisecondsSinceEpoch(curTimestamp - 86400000);
      if( newDate.year == year && newDate.month == month && newDate.day == day){
        return '昨天 ' + zeroize(hour) + ':' + zeroize(minute);
      }else if(curDate.year == year) {
        return zeroize(month) + '-' + zeroize(day);
      }else{
        return year.toString() + '-' + zeroize(month) + '-' + zeroize(day);
      }
    }
  }

  static String zeroize(num) {
    return (num.toString().length == 1 ? '0' : '') + num.toString();
  }
}