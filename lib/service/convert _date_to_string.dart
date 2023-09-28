String getDate(String? date) {
  var dateF = DateTime.parse(date ?? "2021-09-09T12:00:00.000000Z");
  var howTimeWas = DateTime.parse(date ?? "2021-09-09T12:00:00.000000Z")
      .difference(DateTime.now());
  if (dateF.year != DateTime.now().year) {
    return "${dateF.day} ${toMonth(dateF.month)} ${dateF.year}, ${dateF.hour}:${dateF.minute}";
  }
  if (howTimeWas.inDays * -1 > 10) {
    return "${dateF.day} ${toMonth(dateF.month)}, ${dateF.hour}:${dateF.minute}";
  }
  var formattedDate = howTimeWas.inDays * -1 > 1
      ? "${howTimeWas.inDays * -1} days ago"
      : howTimeWas.inDays * -1 == 1
          ? "1 day ago"
          : howTimeWas.inHours * -1 > 0
              ? "${howTimeWas.inHours * -1} hours ago"
              : howTimeWas.inMinutes * -1 > 0
                  ? "${howTimeWas.inMinutes * -1} minutes ago"
                  : "${howTimeWas.inSeconds * -1} seconds ago}";
  return formattedDate;
}

String toMonth(int i) {
  switch (i) {
    case 1:
      return "january";
    case 2:
      return "february";
    case 3:
      return "march";
    case 4:
      return "april";
    case 5:
      return "may";
    case 6:
      return "june";
    case 7:
      return "july";
    case 8:
      return "august";
    case 9:
      return "september";
    case 10:
      return "october";
    case 11:
      return "november";
    case 12:
      return "december";
    default:
      return "january";
  }
}
