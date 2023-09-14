import 'package:intl/intl.dart';

String formatDate(String dateStr) {
  DateTime dateTime = DateFormat('dd-MM-yyyy HH:mm').parse(dateStr);
  // String formattedDate = DateFormat('EEE, MMM d h:mm a').format(dateTime);
  String formattedDate = DateFormat('EEE, MMM d').format(dateTime);
  String formattedTime = DateFormat('h:mm a').format(dateTime);
  String jointTime = "$formattedDate\n$formattedTime";
  return jointTime;
}
