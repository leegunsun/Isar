// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'widget_test.mocks.dart';

class ApiService {
  Dio dio = Dio(BaseOptions(
    connectTimeout: 500,  // 500ms로 연결 타임아웃 설정
    receiveTimeout: 500,  // 500ms로 응답 타임아웃 설정
  ));
  final int maxRetries = 5;

  Future<void> fetchData(String url) async {
    int retryCount = 0;

    // try {
    //   final response = await dio.get('https://example.com');
    // } on DioError catch (e) {
    //   if (e.type == DioErrorType.other && e.error is SocketException) {
    //     print('서버에 연결할 수 없습니다. 네트워크 문제일 가능성이 큽니다.');
    //   } else if (e.type == DioErrorType.connectTimeout) {
    //     print('서버와의 연결이 타임아웃되었습니다. 서버가 응답하지 않거나 연결이 원활하지 않습니다.');
    //   } else if (e.type == DioErrorType.receiveTimeout) {
    //     print('서버 응답이 타임아웃되었습니다. 서버가 응답하지 않거나 연결이 불안정합니다.');
    //   } else {
    //     print('다른 오류가 발생했습니다: ${e.message}');
    //   }
    // }

    while (retryCount < maxRetries) {
      try {
        final response = await dio.get(url);
        print('Success: ${response.data}');
        return; // 성공 시 종료
      } on DioError catch (e) {
        if (e.type == DioErrorType.connectTimeout ||
            e.type == DioErrorType.receiveTimeout) {
          retryCount++;
          print('Timeout occurred. Attempt: $retryCount');

          if (retryCount == maxRetries) {
            print('Timeout 5회 이상 발생');
          }
        } else {
          print('Error: ${e.message}');
          return;
        }
      }
    }
  }
}



@GenerateMocks([Dio])
void main() {
  group('ApiService', () {
    late MockDio mockDio;
    late ApiService apiService;

    setUp(() {
      mockDio = MockDio();  // 이 부분이 제대로 초기화되었는지 확인
      apiService = ApiService()..dio = mockDio;
    });

    test('Should retry up to maxRetries times on timeout', () async {
      when(mockDio.get(any)).thenAnswer(
            (_) async => throw DioError(
          requestOptions: RequestOptions(path: ''),
          type: DioErrorType.connectTimeout,
        ),
      );

      await apiService.fetchData('https://api.example.com/data');

      verify(mockDio.get(any)).called(apiService.maxRetries);
    });
  });
}