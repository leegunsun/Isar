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

  findOne () async{
    var result = await isar.users.filter().idEqualTo(3).findFirst();
    print(result!.id);
  }

}