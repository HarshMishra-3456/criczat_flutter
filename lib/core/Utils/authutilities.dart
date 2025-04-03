import 'package:intl/intl.dart';
import 'package:tempalteflutter/core/localstorage/localstorage.dart';

class Authutilities {
  static dynamic userid = '';
  static String isuserlogin = '';
  static String firebasetoken = '';
  static bool isloaded = true;
  static String useridforpdf = '';
  static String roles = '';
  static int playerlenght = 0;

  Future<void> determineScreen() async {
    if (await Storage().getItem("userid") != null) {
      Authutilities.isuserlogin = await Storage().getItem("userid");
      print(Authutilities.roles);
    } else {}
  }
}

String checkTimePassed(String dateStartIst) {
  // Parse the provided date and time
  DateTime startDateTime = DateTime.parse(dateStartIst);
  DateTime currentDateTime = DateTime.now();

  // Compare the exact date and time including year, month, day, hour, minute, second
  if (startDateTime.isBefore(currentDateTime)) {
    return 'false';  // The start time has already passed
  } else {
    return 'true';   // The start time is in the future
  }
}

String convertTo12HourFormat(String time24Hour) {
  final DateFormat inputFormat = DateFormat('HH:mm');
  final DateFormat outputFormat = DateFormat('h:mm a');

  final DateTime dateTime = inputFormat.parse(time24Hour);
  final String time12Hour = outputFormat.format(dateTime);

  return time12Hour;
}


String formatDateStringToMonthName(String dateStr) {
  try {
    final parts = dateStr.split('-');
    if (parts.length == 3) {
      final year = parts[0];
      final month = int.tryParse(parts[1]);
      final day = parts[2];

      if (month != null && month >= 1 && month <= 12) {
        final monthName = DateTime(int.parse(year), month, int.parse(day));
        final formattedDate = DateFormat('MMMM dd y').format(monthName);
        return formattedDate;
      }
    }
  } catch (e) {
    print(e);
  }

  // Return the original string if conversion fails
  return dateStr;
}




