import 'package:masbros/Resources/Date.dart';

class User {
  final int? id;
  final String? username;
  final String? password;
  final String? email;
  final Date? creationDate;

  User(this.id, this.username, this.password, this.email, this.creationDate);
}
