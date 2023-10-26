import 'package:isar/isar.dart';
import 'package:swf/user.dart';

part 'testcollection.g.dart';

@collection
@Name('Test')
class TestCollection {

  @Name('id')
  Id myObjectId = Isar.autoIncrement; // you can also use id = null to auto increment

  @Name('waIncom')
  String? marchent;

  @ignore
  @Name('passwordIg')
  String? password;

  @Name('listTest')
  List<String>? listTest;

  @Name('embedList')
  List<Recepient>? listRTest;

  @Name('embed')
  Recepient? recipient;
}

@embedded
class Recepient {
  String? name;
  String? address;
}