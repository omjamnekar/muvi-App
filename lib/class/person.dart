import 'package:uuid/uuid.dart';

class PersonInfo {
  PersonInfo({
    String? id,
    required this.personPassword,
    required this.personUsername,
  }) : id = id ?? Uuid().v4();

  String personUsername;
  String personPassword;
  String? id;
}
