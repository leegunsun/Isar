import 'package:decimal/decimal.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:isar/isar.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swf/user.dart';

class TestController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    openIsar();
  }

  Future openIsar () async {
    final dir = await getApplicationDocumentsDirectory();
    final openisar = await Isar.open(
      [UserSchema],
      directory: dir.path,
    );

    isar = openisar;
  }

  late Isar isar;

  findOne() async{
    User? result = await isar.users.filter().idEqualTo(3).findFirst();
    print(result!.name);
  }

  insert () async{
      final user = User()
          ..name = 'gunsun'
          ..age = 10;

      await isar.writeTxn(() async{
        await isar.users.put(user);
      });
  }

  delete () {
    isar.writeTxn(() async {
      final success = await isar.users.delete(3);
      print('users deleted: $success');
    });
  }



}