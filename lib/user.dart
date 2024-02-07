import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String? name;

  int? age;

  List<String>? listTest;

  @Name("user")
  UserModel? userModel;
}

@embedded
class UserModel {
  String? name;
  String? pass;
  String? re;
  String? email;
  String? defaultwallet;

  UserModel({this.name,this.pass,this.re,this.email,this.defaultwallet});

}