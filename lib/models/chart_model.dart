class ChartModel {
  late int _id, _year, _month, _day, _hour, _minute, _duration;

  ChartModel({id, year, month, day, hour, minute, duration}) {
    _id = id;
    _year = year;
    _month = month;
    _day = day;
    _hour = hour;
    _minute = minute;
    _duration = duration;
  }

  get id => _id;
  get hour => _hour;
  get minute => _minute;
  get duration => _duration;
  get year => _year;
  get month => _month;
  get day => _day;

  void setId(id) {
    _id = id;
  }

  void setHour(hour) {
    _hour = hour;
  }

  void setMinute(minute) {
    _minute = minute;
  }

  void setDuration(minute) {
    _minute = minute;
  }

  Map toJson() => {
        'id': _id,
        'year': _year,
        'month': _month,
        'day': _day,
        'hour': _hour,
        'minute': _minute,
        'duration': _duration,
      };
}
