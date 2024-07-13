
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:rive/rive.dart';

class PagingDemo extends StatefulWidget {
  const PagingDemo({super.key});

  @override
  State<PagingDemo> createState() => _PagingDemoState();
}

class _PagingDemoState extends State<PagingDemo> {
  int createInt = 0;
  List<BuildContext> _dialogContexts = [];

  Future<dynamic> testDialog<T>(BuildContext context) {
    final BuildContext dialogContext = context;
    _dialogContexts.add(dialogContext);

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Text("test"),
      );
    });
  }

  void _closeAllDialogs() {
    for (final dialogContext in _dialogContexts) {
      Navigator.of(dialogContext, rootNavigator: true).pop();
    }
    _dialogContexts.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _closeAllDialogs();
        },
        child: Icon(Icons.close),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(100, 100),
          painter: OvalPainter(),
        )

        // ElevatedButton(
        //   onPressed: () async {
        //     for (int i = 0; i < 5; i++) {
        //       testDialog(context);
        //       createInt++;
        //     }
        //
        //     await Future.delayed(Duration(seconds: 1));
        //
        //     Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);
        //
        //     // _closeAllDialogs();
        //   },
        //   child: Text("다이얼 로그 생성"),
        // ),
      ),
    );
  }
}

class OvalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint topPaint = Paint()
      ..color = Colors.blue
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;

    Path topPath = Path();
    // Add an arc to the path
    topPath.addArc(
      Rect.fromLTWH(0, 0, size.width, size.height * 2),
      10,
      -3.14,
    );
    canvas.drawPath(topPath, topPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}







/// An example showing how to drive a StateMachine via one numeric input.
class ArtboardNestedInputs extends StatefulWidget {
  const ArtboardNestedInputs({Key? key}) : super(key: key);

  @override
  State<ArtboardNestedInputs> createState() => _ArtboardNestedInputsState();
}

class _ArtboardNestedInputsState extends State<ArtboardNestedInputs> {
  Artboard? _riveArtboard;
  SMIBool? _circleOuterState;
  SMIBool? _circleInnerState;

  @override
  void initState() {
    super.initState();

    _loadRiveFile();
  }

  Future<void> _loadRiveFile() async {
    final file = await RiveFile.asset('assets/runtime_nested_inputs.riv');

    // The artboard is the root of the animation and gets drawn in the
    // Rive widget.
    final artboard = file.artboardByName("MainArtboard")!.instance();
    var controller =
    StateMachineController.fromArtboard(artboard, 'MainStateMachine');
    // Get the nested input CircleOuterState in the nested artboard CircleOuter
    _circleOuterState =
        artboard.getBoolInput("CircleOuterState", "CircleOuter");
    // Get the nested input CircleInnerState at the nested artboard path
    // -> CircleOuter
    //    -> CircleInner
    _circleInnerState =
        artboard.getBoolInput("CircleInnerState", "CircleOuter/CircleInner");
    if (controller != null) {
      artboard.addController(controller);
    }
    setState(() => _riveArtboard = artboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nested Inputs'),
      ),
      body: Center(
        child: _riveArtboard == null
            ? const SizedBox()
            : Stack(
          children: [
            Positioned.fill(
              child: Rive(
                artboard: _riveArtboard!,
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned.fill(
              bottom: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: const Text('Outer Circle'),
                    onPressed: () {
                      if (_circleOuterState != null) {
                        _circleOuterState!.value =
                        !_circleOuterState!.value;
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    child: const Text('Inner Circle'),
                    onPressed: () {
                      if (_circleInnerState != null) {
                        _circleInnerState!.value =
                        !_circleInnerState!.value;
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}














// class PagingDemo extends StatefulWidget {
//   @override
//   _PagingDemoState createState() => _PagingDemoState();
// }
//
// class _PagingDemoState extends State<PagingDemo> {
//   final ScrollController _scrollController = ScrollController();
//   List<dynamic> _items = [];
//   int _page = 1;
//   bool _isLoading = false;
//   final Dio dio = Dio();
//
//   // Mock Adapter 설정
//   DioAdapter? _dioAdapter;
//
//   @override
//   void initState() {
//     super.initState();
//     _dioAdapter = DioAdapter(dio: dio);
//     _setupMockAdapter();
//     _fetchData();
//
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
//         _fetchData();
//       }
//     });
//   }
//
//   void _setupMockAdapter() {
//     _dioAdapter?.onGet(
//       'https://api.example.com/data',
//           (server) => server.reply(
//         200,
//         List.generate(10, (index) => {'id': index + 1 + (_page - 1) * 10}),
//       ),
//       queryParameters: {'page': _page, 'limit': 10},
//     );
//   }
//
//   Future<void> _fetchData() async {
//     if (_isLoading) return;
//     setState(() {
//       _isLoading = true;
//     });
//
//     final response = await dio.get('https://api.example.com/data', queryParameters: {'page': _page, 'limit': 10});
//     await Future.delayed(Duration(seconds: 2));
//     if (response.statusCode == 200) {
//       List<dynamic> newData = response.data;
//       setState(() {
//         _items.addAll(newData);
//         _page++;
//         // Mock 설정 업데이트
//         _dioAdapter?.onGet(
//           'https://api.example.com/data',
//               (server) => server.reply(
//             200,
//             List.generate(10, (index) => {'id': index + 1 + (_page - 1) * 10}),
//           ),
//           queryParameters: {'page': _page, 'limit': 10},
//         );
//         _isLoading = false;
//       });
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//       throw Exception('Failed to load data');
//     }
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//           _fetchData();
//         },
//       ),
//       appBar: AppBar(
//         title: Text('Paging Demo'),
//       ),
//       body: Stack(
//         children: [
//           ListView.builder(
//             controller: _scrollController,
//             itemCount: _items.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text('Item ${_items[index]['id']}'),
//               );
//             },
//           ),
//           if (_isLoading)
//             Positioned.fill(
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: Container(
//                 padding: EdgeInsets.all(8.0),
//                 color: Colors.black.withOpacity(0.5),
//                 child: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }