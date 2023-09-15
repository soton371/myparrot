String myDay(day) {
    if (day.day.toString().length == 1) {
      return "0${day.day}";
    } else {
      return day.day.toString();
    }
  }