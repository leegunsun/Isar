import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swf/controller.dart';
import 'package:swf/user.dart';

void main() {
  Get.put(TestController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var list = [].obs;
  final c = Get.find<TestController>();

  // test() async {
  //   final dir = await getApplicationDocumentsDirectory();
  //   final isar = await Isar.open(
  //     [UserSchema],
  //     directory: dir.path,
  //   );
  //
  //   final newUser = User()
  //     ..name = 'Jane Doe'
  //     ..age = 36;
  //
  //   await isar.writeTxn(() async {
  //     await isar.users.put(newUser); // insert & update
  //   });
  //
  //   isar.name;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                c.findOne();
              },
              child: Text('find one')),
          ElevatedButton(
              onPressed: () {
                c.delete();
              },
              child: Text('delete')),
          ElevatedButton(
              onPressed: () {
                c.insert();
              },
              child: Text('create'))
        ],
      ),
    );
  }
}
