
// given the current date and passed index, return name of Day
String forecastDay(int ind) {
  String dayName = "";

  var date = DateTime.now();

  if (ind == 0) {
    dayName = "Today";
  } else if (ind == 1) {
    dayName = "Tomorrow";
  } else {
    date.weekday; //1-7
    switch ((date.weekday - 1 + ind) % 7) {
      case 0:
        {
          dayName = "Monday";
          break;
        }
      case 1:
        {
          dayName = "Tuesday";
          break;
        }
      case 2:
        {
          dayName = "Wednesday";
          break;
        }
      case 3:
        {
          dayName = "Thursday";
          break;
        }
      case 4:
        {
          dayName = "Friday";
          break;
        }
      case 5:
        {
          dayName = "Saturday";
          break;
        }
      case 6:
        {
          dayName = "Sunday";
          break;
        }
      default:
        {
          dayName = "ERROR";
        }
    }
  }
  return dayName;
}