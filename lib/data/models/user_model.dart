import 'package:kaonic/data/models/contact_model.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class UserModel {
  UserModel({
    required this.username,
    required this.passcode,
    this.key = const [],
    required this.id,
    this.logged = false,
  });
  @Id()
  int id;
  final String username;
  final String passcode;
  final bool logged;
  List<int> key;
  final contacts = ToMany<ContactModel>();

  UserModel copyWith({
    String? username,
    String? passcode,
    bool? logged,
  }) {
    return UserModel(
        username: username ?? this.username,
        passcode: passcode ?? this.passcode,
        logged: logged ?? this.logged,
        key: key,
        id: id);
  }
}
