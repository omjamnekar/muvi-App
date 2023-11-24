import 'package:intl/intl.dart';

class MyClass {
  late DateTime currentDateTime;
  late String currentTime;

  MyClass() {
    currentDateTime = DateTime.now();
    currentTime = DateFormat('MM/dd/yyyy').format(currentDateTime);
  }

  String printFormattedDate() {
    return currentTime;
  }
}
