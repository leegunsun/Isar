
import 'dart:io';
import 'dart:math' as math;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swf/controller.dart';
import 'package:swf/firebase_options.dart';
import 'package:swf/home/bottomnav/bottomnav.dart';
import 'package:swf/home/f_home/home.dart';
import 'package:swf/home/f_setting/setting.dart';
import 'package:swf/rive/artboardnestedinputs.dart';
import 'package:swf/rive/event_star_rating.dart';
import 'package:swf/testlab.dart';

import 'firebase/fire_storage/fire_storage.dart';
import 'home/f_input/input.dart';
import 'home/f_input/input_binding.dart';
import 'home/f_input/input_contoller.dart';
import 'home/f_setting/pagetest.dart';
import 'main_style/main_Theme_data.dart';
import 'main_style/main_style.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 커스텀 출력을 사용하는 Logger 초기화
  Logger logger = Logger(output: FileOutput());

  // Logger의 초기화가 완료될 때까지 대기
  await logger.init;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  // FlutterNativeSplash.preserve(widgetsBinding: bindings);
  Get.put(logger);
  Get.put(FireStorage());
  Get.put(TestController());
  runApp(const MyApp());
}


class FileOutput extends LogOutput {
  late File _logFile;

  FileOutput() {
    _initializeLogFile();
  }

  Future<void> _initializeLogFile() async {
    final directory = await getApplicationDocumentsDirectory();
    _logFile = File('${directory.path}/app_logs.txt');
    if (!await _logFile.exists()) {
      await _logFile.create();
    }
  }

  @override
  Future<void> init() async {
    await _initializeLogFile();
  }

  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      if (event.level.index >= Level.error.index) {
        _logFile.writeAsStringSync('$line\n', mode: FileMode.append);
      }
    }
  }

  @override
  Future<void> destroy() async {
    // Clean up resources if necessary
  }
}
//
// void setupLogging() {
//   Logger.level = Level.fatal;
//   Logger.addLogListener((event) {
//       print('${event.level.name}: ${event.time}: ${event.message}, ${event.error}');
//       _writeLogToFile(event);
//   });
// }
//
// Future<void> _writeLogToFile(LogEvent record) async {
//   final directory = await getApplicationDocumentsDirectory();
//   final path = '${directory.path}/app_logs.txt';
//   final file = File(path);
//   final logMessage = '${record.level.name}: ${record.time}: ${record.message}\n ${record.stackTrace}';
//   await file.writeAsString(logMessage, mode: FileMode.append);
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: MainThemeData().mainStyle,
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

enum MerchantEditText {
  shortName,
  password1,
  password2,
  feeRate,
  address1,
  address2,
  mobile,
  url,
  // city,
  country,
  postCode,
  referralCode,
  file,
  max,
}

class _MyHomePageState extends State<MyHomePage>  {

  // var list = [].obs;
  // final c = Get.find<TestController>();
  // final controller = TextEditingController();
  // final editTextController = List.generate(
  //     MerchantEditText.max.index, (index) => TextEditingController());
  final List<GlobalKey<NavigatorState>> navigatorKeys = [];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> page = [
    Navigator(
        key: GlobalKey<NavigatorState>(),
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => HomeView(),
          );
        }),
    Navigator(
        key: GlobalKey<NavigatorState>(),
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) {
              InputBinding().dependencies();
              return InputView(); }
          );
        }),
    Navigator(
        key: GlobalKey<NavigatorState>(),
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
              builder: (context) {
                // InputBinding().dependencies();
                // return EventStarRating();
                return Setting();
              }
          );
        }),
    Navigator(
        key: GlobalKey<NavigatorState>(),
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
              builder: (context) {
                // InputBinding().dependencies();
                return TestLab();
              }
          );
        })
  ];

  Future<bool> _showExitConfirmationDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('앱 종료'),
        content: Text('앱을 종료하시겠습니까?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('아니요'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('예'),
          ),
        ],
      ),
    ) ??
        false;
  }

  void _handlePopInvoked(bool didPop) async {
    if (!didPop) {
      bool shouldExit = await _showExitConfirmationDialog();
      if (shouldExit) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  PopScope (
      canPop: false,
      onPopInvoked: _handlePopInvoked,
      child: Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: _selectedIndex,
            children: page,
          ),
        ),
        bottomNavigationBar: BottomNav(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }

  Widget testContainer() {
    double fontSize = 20.0;
    return Container(
        color: Colors.redAccent,
        height: 100,
        width: 280,
        child: Center(
          child: WalletBalanceWidget(
             balance: 8888888888.888888888888888888,
            // style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ));
  }
}

class WalletBalanceWidget extends StatelessWidget {
  final double balance;

  WalletBalanceWidget({Key? key, required this.balance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 정수와 소수 부분을 분리
        List<String> parts = balance.toString().split('.');
        String integerPart = parts[0];
        String decimalPart = parts.length > 1 ? parts[1] : '';

        // 정수 부분의 포맷팅
        String formattedInteger = NumberFormat('#,###').format(int.parse(integerPart));

        // 폰트 크기 및 소수점 자리수를 부모 위젯의 크기에 맞춰 계산
        double fontSize = calculateFontSize(constraints, integerPart.length);
        double decimalPlacesToShow = calculateDecimalPlacesToShow(constraints, integerPart.length).floor().toDouble();
        String parse1 = fontSize.toString().split('.')[1];

        // 소수 부분 자르기 및 포맷팅
        String formattedDecimal = decimalPart.padRight(int.parse(parse1), '0').substring(0, int.parse(parse1));

        return RichText(
          maxLines: 1,
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: fontSize),
            children: [
              TextSpan(text: formattedInteger),
              TextSpan(
                text: '.$formattedDecimal',
              ),
            ],
          ),
        );
      },
    );
  }

  double calculateFontSize(BoxConstraints constraints, int integerLength) {
    double baseFontSize = constraints.maxWidth / 15; // 기본 폰트 크기를 최대 너비에 비례하게 설정
    // 정수 부분의 길이에 따라 폰트 크기 조절
    if (integerLength > 13) {
      return baseFontSize * 0.8; // 정수 부분이 길면 폰트 크기 감소
    } else if (integerLength < 7) {
      return baseFontSize * 1.2; // 정수 부분이 짧으면 폰트 크기 증가
    }
    return baseFontSize;
  }

  double calculateDecimalPlacesToShow(BoxConstraints constraints, int integerLength) {
    // 부모 위젯의 최대 너비를 기준으로 소수점 자리수 결정
    double maxDecimalPlaces = 18.0; // 최대 소수점 자리수
    double minDecimalPlaces = 6.0;  // 최소 소수점 자리수

    // 부모 위젯의 너비에 따라 소수점 자리수 결정
    double widthFactor = constraints.maxWidth / 500; // 너비에 따른 인자 계산
    double decimalPlaces = (maxDecimalPlaces - minDecimalPlaces) * widthFactor + minDecimalPlaces;

    // 소수점 자리수가 최대 및 최소 범위 내에 있는지 확인
    decimalPlaces = decimalPlaces.clamp(minDecimalPlaces, maxDecimalPlaces);

    // 정수 부분이 길 경우, 소수점 자리수를 최소 6자리로 유지
    if (integerLength > 13) {
      decimalPlaces = math.max(minDecimalPlaces, decimalPlaces);
    }

    return decimalPlaces;
  }

}

class CustomTextOverflowWidget extends StatelessWidget {
  final String text;
  final TextStyle style;
  final double maxWidth;

  const CustomTextOverflowWidget({
    Key? key,
    required this.text,
    required this.style,
    this.maxWidth = 100.0, // 여기서 최대 너비를 설정합니다.
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final TextPainter textPainter = TextPainter(
          text: TextSpan(text: text, style: style),
          maxLines: 1,
        )..layout(maxWidth: maxWidth);

        if (textPainter.didExceedMaxLines) {
          // 텍스트가 너비를 초과하는 경우, 오버플로 처리
          return Text(
            text,
            style: style,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          );
        } else {
          // 텍스트가 너비에 맞는 경우, 일반적으로 표시
          return Text(text, style: style);
        }
      },
    );
  }
}

// Material(child: customS());
//   Scaffold(
//   body: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       TextFormField(
//         controller: controller,
//       ),
//       Text('isar find sample'),
//       Row(
//         children: [
//           ElevatedButton(
//               onPressed: () {
//                 c.findOne();
//               },
//               child: Text('find one')),
//           ElevatedButton(
//               onPressed: () {
//                 c.findOne();
//               },
//               child: Text('TCfind one')),
//         ],
//       ),
//       Text('isar create sample'),
//       Row(
//         children: [
//           ElevatedButton(
//               onPressed: () {
//                 c.insert();
//               },
//               child: Text('insert one')),
//           ElevatedButton(
//               onPressed: () {
//                 c.insertTC();
//               },
//               child: Text('insertTC one')),
//         ],
//       ),
//       ElevatedButton(
//           onPressed: () {
//             c.delete();
//           },
//           child: Text('delete')),
//       ElevatedButton(
//           onPressed: () {
//             c.insert();
//           },
//           child: Text('create')),
//       ElevatedButton(
//           onPressed: () {
//             c.updateisar();
//           },
//           child: Text('update')),
//       // testContainer()
//     ],
//   ),
// );