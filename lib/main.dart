
import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:app_links/app_links.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
  final FlutterLocalNotificationsPlugin _local = FlutterLocalNotificationsPlugin();


  @override
  void initState() {
    super.initState();
    _initNoti();
    _initializeFCM();
  }

  void _initNoti () async {

    AndroidInitializationSettings android =
    const AndroidInitializationSettings("@mipmap/ic_launcher");
    DarwinInitializationSettings ios = const DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    InitializationSettings settings =
    InitializationSettings(android: android, iOS: ios);
    await _local.initialize(settings);
  }

  void _initializeFCM() {
    // Foreground 메시지 수신
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        print('Message also contained a notification: ${message.notification?.title}');
        print('Message also contained a notification: ${message.notification?.body}');
        AndroidNotification? and = message.notification?.android;
        print(and);
      }
    });

    // Background 메시지 수신
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
    });

    // 앱이 종료된 상태에서 수신한 메시지
    // FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) {
    //   if (message != null) {
    //     print('Message clicked from terminated state!');
    //   }
    // });

    // _firebaseMessaging.getToken().then((String token) {
    //   assert(token != null);
    //   print("FCM Token: $token");
    // });
  }

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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // NotificationDetails details = const NotificationDetails(
            //   iOS: DarwinNotificationDetails(
            //     presentAlert: true,
            //     presentBadge: true,
            //     presentSound: true,
            //   ),
            //   android: AndroidNotificationDetails(
            //     "1",
            //     "test",
            //     importance: Importance.max,
            //     priority: Priority.high,
            //   ),
            // );
            //
            // _local.show(1, "title", "body", details);

          // Get.to(() => QrScan());
          Get.to(() => TestQR());

          },
        ),
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


class TestQR extends StatefulWidget {
  const TestQR({super.key});

  @override
  State<TestQR> createState() => _TestQRState();
}

class _TestQRState extends State<TestQR> {
  @override
  Widget build(BuildContext context) {

    StreamSubscription _sub;
    late AppLinks _appLinks;

    void openAppLink(Uri uri) {
      print(uri);
    }

    Future<void> initDeepLinks() async {
      _appLinks = AppLinks();

      _sub = _appLinks.uriLinkStream.listen((event) {
        print('ononononon : $event');
        openAppLink(event);
      });
    }

    @override
    void initState() {
      super.initState();
      initDeepLinks();
    }


    return Scaffold(
      body: Center(
        child: QrImageView(
          data: "http://localhost:8081/qrTest",
          version: QrVersions.auto,
          errorCorrectionLevel: QrErrorCorrectLevel.H,
          embeddedImage: AssetImage("assets/testPng.png"),
          embeddedImageStyle: QrEmbeddedImageStyle(
            size: Size(100, 100),
          ),
        ),
      ),
    );
  }
}
class QrScan extends StatefulWidget {
  const QrScan({Key? key}) : super(key: key);

  @override
  State<QrScan> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  final qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? barcode;
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context),
          Positioned(bottom: 10, child: buildResult()),
          Positioned(
            top: Get.mediaQuery.padding.top + 8,
            left: 10,
            child: Text(
              'QR Code Scan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.withOpacity(0.7),
              ),
            ),

          ),
        ],
      ),
    );
  }

  Widget buildResult() {
    if (barcode != null) {
      controller?.pauseCamera();

      Future.microtask(() {
//        사용자Web(uri: barcode!.code.toString()
        controller?.resumeCamera();
      });
    }
    return Column(
      children: [
        Text(
          barcode != null ? 'Result : ${barcode!.code}' : 'Scan a code!',
          maxLines: 3,
        ),
        const Text(
          'Qr 코드 용지를 사각 안에 맞혀 스캔해 주세요',
        ),
      ],
    );
  }


  // This method is called when the permission is set
  void _onPermissionSet(QRViewController ctrl, bool p) {
    openAppSettings();
    // print('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    // if (!p) {
    //   // Handle the case when permission is denied
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Camera permission denied')),
    //   );
    // }
  }

  Widget buildQrView(BuildContext context) =>
      QRView(
        onPermissionSet: _onPermissionSet,
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: Colors.cyanAccent,
            borderRadius: 10,
            borderLength: 20,
            borderWidth: 10,
            cutOutSize: MediaQuery
                .of(context)
                .size
                .width * 0.8),
      );

  void onQRViewCreated(QRViewController _controller) {
    controller = _controller;

    controller!.scannedDataStream.listen((scanData) async {
      setState(() {
        barcode = scanData;
      });
    });
  }
}


// Future<void> permissionRequest(
//     {required BuildContext context,
//       required Permission permission,}) async {
//   // print('---> permission status: ${permission.status}');
//
//   if (await permission.request().isGranted) {
//     if (callback != null) {
//       callback();
//     }
//   } else {
//     openAppSettings();
//     // context.showFlashDialog(
//     //     content:
//     //         Text('${permissionName[permission]} 권한을 허용해주세요.\n설정 화면으로 가시겠습니까?'),
//     //     positiveActionBuilder: (context, flashController, _) {
//     //       return TextButton(
//     //         onPressed: () {
//     //           flashController.dismiss();
//     //           openAppSettings();
//     //         },
//     //         child: Text('예'),
//     //       );
//     //     },
//     //     negativeActionBuilder: (context, flashController, _) {
//     //       return TextButton(
//     //         onPressed: () {
//     //           flashController.dismiss();
//     //         },
//     //         child: Text('아니오'),
//     //       );
//     //     });
//   }
// }
//