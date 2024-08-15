// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'dart:io';

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

    while (retryCount < maxRetries) {
      try {
        final response = await dio.get(url);
        print('Success: ${response.data}');
        return; // 성공 시 종료
      } catch (e) {
        if(e is DioError) {
          if (e.type == DioErrorType.connectTimeout && e.error is SocketException) {
            print('서버에 연결할 수 없습니다. 네트워크 문제일 가능성이 큽니다.');
            rethrow;
          } else if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
            print('서버와의 연결이 타임아웃되었습니다. 서버가 응답하지 않거나 연결이 원활하지 않습니다.');
            retryCount++;
            print('Timeout occurred. Attempt: $retryCount');

            if (retryCount == maxRetries) {
              print('Timeout 5회 이상 발생');
              rethrow; // 에러를 다시 던짐
            }
          } else {
            print('Error: ${e.message}');
            rethrow; // 에러를 다시 던짐
          }
        } else {
          rethrow;
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
      mockDio = MockDio();
      apiService = ApiService()..dio = mockDio;
    });

    test('Should retry up to maxRetries times on timeout', () async {
      when(mockDio.get(any)).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: ''),
          type: DioErrorType.connectTimeout,
          error: SocketException('Failed to connect'),
        ),
      );

      try {
        await apiService.fetchData('https://api.example.com/data');
      } catch (e) {
        // Do nothing
      }

      verify(mockDio.get(any)).called(1);
    });

    test('Should throw error after maxRetries exceeded', () async {
      when(mockDio.get(any)).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: ''),
          type: DioErrorType.connectTimeout,
        ),
      );

      expect(
            () async => await apiService.fetchData('https://api.example.com/data'),
        throwsA(isA<DioError>()),
      );

      verify(mockDio.get(any)).called(apiService.maxRetries);
    });
  });
}
