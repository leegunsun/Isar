import 'package:decimal/decimal.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:isar/isar.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swf/igtest.dart';
import 'package:swf/testcollection.dart';
import 'package:swf/user.dart';

class TestController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    openIsar();
  }

  Future openIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    final namedopenisar =
        await Isar.open([UserSchema, TestCollectionSchema, IgTestSchema],
            // directory: '/data/user/1/com.example.swf/app_flutter', // ERROR CODE
            directory: '${dir.path}',
            name: 'test1',
            inspector: true);

    print('${dir.path}');

    final openisar = await Isar.open(
        [UserSchema, TestCollectionSchema, IgTestSchema],
        directory: dir.path, name: 'default', inspector: true);

    isar = namedopenisar;
  }

  late Isar isar;

  findOne() async {
    User? result = await isar.users.filter().idEqualTo(3).findFirst();
    print(result!.name);
  }

  findTC() async {
    TestCollection? result =
        await isar.testCollections.filter().myObjectIdEqualTo(1).findFirst();
    print(result!.marchent);
  }

  insert() async {
    final user = User()
      ..name = 'gunsun'
      ..age = 10;

    await isar.writeTxn(() async {
      await isar.users.put(user);
    });
  }

  insertTC() async {
    final testCollection = TestCollection()
      ..marchent = '0x58akldsjg82ldkngalsdkngldk'
      ..password = 'password'
      ..listRTest = [
        Recepient()
          ..name = 'Recipient1'
          ..address = 'Address1',
        Recepient()
          ..name = 'Recipient2'
          ..address = 'Address2'
      ]
      ..listTest = ['name', 'add'];

    await isar.writeTxn(() async {
      await isar.testCollections.put(testCollection);
    });
  }

  updateisar() async {
    User? users = await isar.users.filter().idEqualTo(7).findFirst();
    users!.age = 30;

    await isar.writeTxn(() async {
      await isar.users.put(users);
    });
  }

  delete() {
    isar.writeTxn(() async {
      final success = await isar.users.delete(3);
      print('users deleted: $success');
    });
  }
}
