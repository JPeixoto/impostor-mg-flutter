import 'package:uuid/uuid.dart';
import 'role.dart';

class Player {
  final String id;
  String name;
  Role? role;
  bool isEliminated;

  Player({
    required this.name,
    String? id,
    this.role,
    this.isEliminated = false,
  }) : id = id ?? const Uuid().v4();

  void resetForNewRound() {
    role = null;
    isEliminated = false;
  }
}
