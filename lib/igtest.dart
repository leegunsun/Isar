import 'package:isar/isar.dart';
import 'package:swf/user.dart';

part 'igtest.g.dart';

@collection
class IgTest {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  @Name('igName')
  String? igUsername;

  @Name('igAge')
  int? age;
}