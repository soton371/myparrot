String myDay(day) {
  if (day.day.toString().length == 1) {
    return "0${day.day}";
  } else {
    return day.day.toString();
  }
}

String myMonth(day) {
  if (day.month.toString().length == 1) {
    return "0${day.month}";
  } else {
    return day.month.toString();
  }
}